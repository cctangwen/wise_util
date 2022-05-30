import 'package:flutter/material.dart';

import '/widget/wise_divider.dart';
import '/widget/wise_multi_state/wise_multi_state_widget.dart';
import '/widget/wise_pull_to_refresh.dart';
import '/widget/wise_skeleton.dart';

///分页加载
class WisePagedLoadList<T> extends StatefulWidget {
  final Key? key;

  ///分页查询方法
  final Future<List<T>> Function(Map<String, dynamic>) future;

  ///初始化装载数据
  final Map<String, dynamic>? payload;

  final Widget? separatorBuilder;

  ///单页数据大小，默认20条
  final int pageSize;

  ///行组件
  final Widget Function(T) rowBuilder;

  final Widget? loadingWidget;

  final bool shrinkWrap;

  final bool enableLoadMore;

  WisePagedLoadList({
    this.key,
    required this.future,
    required this.rowBuilder,
    this.shrinkWrap = false,
    this.separatorBuilder,
    this.pageSize = 20,
    this.payload,
    this.enableLoadMore = true,
    this.loadingWidget,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => WisePagedLoadListState<T>();
}

class WisePagedLoadListState<T> extends State<WisePagedLoadList> {
  ///所有数据集合
  List<T> _data = [];

  ///页码
  int _pageNum = 1;

  ///装载数据
  Map<String, dynamic>? _payload;

  @override
  void initState() {
    _payload = widget.payload;
    super.initState();
  }

  var multiStateKey = GlobalKey<WiseMultiStateWidgetState>();

  @override
  Widget build(BuildContext context) {
    Widget _successWidget;
    _successWidget = WisePullToRefresh(
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: () async {
          await _refresh();
        },
        onLoading: () async {
          if (!widget.enableLoadMore) {
            return false;
          }
          return await _loadMore();
        },
        child: ListView.separated(
            shrinkWrap: widget.shrinkWrap,
            itemBuilder: (BuildContext context, int index) {
              return (widget as WisePagedLoadList<T>).rowBuilder(_data[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return widget.separatorBuilder ?? WiseDivider();
            },
            itemCount: _data.length));

    return WiseMultiStateWidget(
      key: multiStateKey,
      future: () async {
        return await _loadMore();
      },
      loadingWidget: widget.loadingWidget ??
          WiseSkeleton(
            wiseSkeletonType: WiseSkeletonType.listView2,
            mainAxisCount: 20,
          ),
      successWidget: _successWidget,
    );
  }

  ///获取数据
  Future<List<T>> _fetchData({int? pageNum}) async {
    Map<String, dynamic> params = Map<String, dynamic>();
    params["page_num"] = pageNum ?? _pageNum;
    params["page_size"] = widget.pageSize;
    if (null != _payload) {
      _payload!.forEach((key, value) {
        if (null != value) params[key] = value;
      });
    }
    return await (widget as WisePagedLoadList<T>).future(params);
  }

  ///上拉加载更多
  Future<bool> _loadMore() async {
    List<T> newData = await _fetchData();
    if (newData.length > 0) {
      setState(() {
        _data.addAll(newData);
        _pageNum++;
      });
    }
    return newData.length > 0;
  }

  ///重置装载数据
  Future<void> resetPayload(Map<String, dynamic>? payload,
      {bool replaceAll = true}) async {
    ///全部替换参数
    if (replaceAll) {
      _payload = payload;
    } else {
      ///增量替换参数
      if (_payload == null) {
        _payload = Map<String, dynamic>();
      }
      payload!.forEach((key, value) {
        _payload![key] = value;
      });
    }
    await _refresh();
  }

  ///重置装载数据
  Future<void> reload() async {
    await _refresh();
  }

  ///下拉刷新
  Future<void> _refresh() async {
    _pageNum = 1;
    List<T> newData = await _fetchData();
    if (newData.length == 0) {
      multiStateKey.currentState!.forceShowEmptyView();
    } else {
      multiStateKey.currentState!.forceShowSuccessView();
    }
    setState(() {
      _data.clear();
      _data.addAll(newData);
      _pageNum++;
    });
  }
}
