import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wise_util/widget/wise_multi_state/wise_data_status.dart';
import 'package:wise_util/widget/wise_multi_state/wise_mulit_state_no_data.dart';
import 'package:wise_util/widget/wise_multi_state/wise_mulit_state_no_network.dart';

import '../wise_skeleton.dart';

///异步加载多状态页面组件（加载中、空数据、网络错误、成功状态业务组件）。
///支持错误状态，点击刷新。
class WiseMultiStateWidget extends StatefulWidget {
  final Key? key;

  ///成功状态业务组件
  final Widget successWidget;

  ///异步加载方法
  ///返回true，则显示成功的业务组件
  ///返回false，则显示空数据状态
  ///返回null，则显示网络错误状态
  final Future<bool?> Function() future;

  final Widget? loadingWidget;

  final Widget? noDataWidget;

  WiseMultiStateWidget({
    this.key,
    required this.successWidget,
    required this.future,
    this.loadingWidget,
    this.noDataWidget,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => WiseMultiStateWidgetState();
}

class WiseMultiStateWidgetState extends State<WiseMultiStateWidget> {
  WiseDataStatus _wiseDataStatus = WiseDataStatus.loading;

  String? _errorMsg;

  @override
  void initState() {
    _executeFuture();
    super.initState();
  }

  forceShowSuccessView() {
    setState(() {
      _wiseDataStatus = WiseDataStatus.success;
    });
  }

  forceShowEmptyView() {
    setState(() {
      _wiseDataStatus = WiseDataStatus.empty;
    });
  }

  forceShowLoadingView() {
    setState(() {
      _wiseDataStatus = WiseDataStatus.loading;
    });
  }

  _executeFuture() async {
    setState(() {
      _wiseDataStatus = WiseDataStatus.loading;
    });
    bool? resp;
    _errorMsg = null;
    try {
      resp = await widget.future();
    } catch (e) {
      print(e);
      _errorMsg = e.toString();
    }
    if (null == resp) {
      _wiseDataStatus = WiseDataStatus.fail;
    } else if (true == resp) {
      _wiseDataStatus = WiseDataStatus.success;
    } else {
      _wiseDataStatus = WiseDataStatus.empty;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: _buildView(),
    );
  }

  Widget _buildView() {
    if (_wiseDataStatus == WiseDataStatus.loading) {
      return widget.loadingWidget ??
          WiseSkeleton(
            wiseSkeletonType: WiseSkeletonType.listView,
            mainAxisCount: 20,
          );
    } else if (_wiseDataStatus == WiseDataStatus.fail) {
      return WiseMultiStateNoNetwork(
        errorMessage: _errorMsg,
        retry: () {
          _executeFuture();
        },
      );
    } else if (_wiseDataStatus == WiseDataStatus.empty) {
      return widget.noDataWidget ?? WiseMultiStateNoData();
    } else {
      return widget.successWidget;
    }
  }
}
