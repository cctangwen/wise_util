import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../wise_skeleton.dart';
import 'wise_mulit_state_no_data.dart';
import 'wise_mulit_state_no_network.dart';

///异步加载多状态页面组件（加载中、空数据、网络错误、成功状态业务组件）。
///支持错误状态，点击刷新。
class WiseMultiStateWidget extends StatefulWidget {
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
    required this.successWidget,
    required this.future,
    this.loadingWidget,
    this.noDataWidget,
  });

  @override
  State<StatefulWidget> createState() => _WiseMultiStateWidgetState();
}

class _WiseMultiStateWidgetState extends State<WiseMultiStateWidget> {
  Future<bool?>? _future;

  @override
  void initState() {
    _future = widget.future();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {

            ///异步操作完成
            case ConnectionState.done:
              if (snapshot.hasData) {
                if (snapshot.data) {
                  return widget.successWidget;
                } else {
                  return widget.noDataWidget ?? WiseMultiStateNoData();
                }
              } else {
                ///无返回或返回的为null，显示网络错误状态
                return WiseMultiStateNoNetwork(
                  retry: () {
                    setState(() {
                      _future = widget.future();
                    });
                  },
                );
              }

            ///异步数据处理中
            case ConnectionState.waiting:
            default:
              return widget.loadingWidget ??
                  WiseSkeleton(
                    wiseSkeletonType: WiseSkeletonType.listView,
                    mainAxisCount: 20,
                  );
          }
        },
      ),
    );
  }
}
