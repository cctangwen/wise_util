import 'package:flutter/material.dart';

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

  WisePagedLoadList({
    this.key,
    required this.future,
    required this.rowBuilder,
    this.separatorBuilder,
    this.pageSize = 20,
    this.payload,
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

  @override
  Widget build(BuildContext context) {
    return WiseMultiStateWidget(
      future: () async {
        return await _loadMore();
      },
      loadingWidget: WiseSkeleton(
        wiseSkeletonType: WiseSkeletonType.listView,
        mainAxisCount: 20,
      ),
      successWidget: WisePullToRefresh(
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () async {
            await _refresh();
          },
          onLoading: () async {
            return await _loadMore();
          },
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return (widget as WisePagedLoadList<T>)
                    .rowBuilder(_data[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return widget.separatorBuilder ?? Divider(height: 1);
              },
              itemCount: _data.length)),
    );
  }

  ///获取数据
  Future<List<T>> _fetchData({int? pageNum}) async {
    Map<String, dynamic> params = Map<String, dynamic>();
    params["page_num"] = pageNum ?? _pageNum;
    params["page_size"] = widget.pageSize;
    if (null != _payload) params.addAll(_payload!);
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
  Future<void> resetPayload(Map<String, dynamic>? payload) async {
    setState(() {
      _payload = payload;
    });
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
    setState(() {
      _data.clear();
      _data.addAll(newData);
      _pageNum++;
    });
  }
}
