import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';

import '/widget/wise_multi_state/wise_multi_state_widget.dart';
import '/widget/wise_pull_to_refresh.dart';
import '/widget/wise_skeleton.dart';

///分组分页加载，
///key：分组数据标识，若[WiseGroupPagedLoadListHeaderData.key]相同，则认为是同一组的数据
///value：分组数据内容，用于构建header使用，[WiseGroupPagedLoadListHeaderData.value] 取第一次数据的header
class WiseGroupPagedLoadListHeaderData<H> {
  final String key;

  final H value;

  WiseGroupPagedLoadListHeaderData({required this.key, required this.value});
}

///分组分页加载
///T：单条数据的数据泛型
///H：分组数据的数据泛型
class WiseGroupPagedLoadList<T, H> extends StatefulWidget {
  ///分页查询方法
  final Future<List<T>> Function(Map<String, dynamic>) future;

  ///数据分组。返回单条数据的分组数据
  final WiseGroupPagedLoadListHeaderData<H> Function(T) group;

  ///初始化装载数据
  final Map<String, dynamic>? payload;

  ///单页数据大小，默认20条
  final int pageSize;

  ///行组件
  final Widget Function(T) rowBuilder;

  ///行组件
  final Widget Function(H) headerBuilder;

  WiseGroupPagedLoadList({
    required this.future,
    required this.group,
    required this.rowBuilder,
    required this.headerBuilder,
    this.pageSize = 20,
    this.payload,
  });

  @override
  State<StatefulWidget> createState() => WiseGroupPagedLoadListState<T, H>();
}

class WiseGroupPagedLoadListState<T, H> extends State<WiseGroupPagedLoadList> {
  ///所有数据集合，key为[WiseGroupPagedLoadListHeaderData.key]
  Map<String, List<T>> _data = Map<String, List<T>>();

  Map<String, H> _header = Map<String, H>();

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
        child: GroupListView(
          sectionsCount: _data.keys.toList().length,
          countOfItemInSection: (int section) {
            return _data.values.toList()[section].length;
          },
          itemBuilder: (BuildContext context, IndexPath index) {
            T data = _data.values.toList()[index.section][index.index];
            return (widget as WiseGroupPagedLoadList<T, H>).rowBuilder(data);
          },
          separatorBuilder: (BuildContext context, IndexPath index) {
            return Divider(height: 1);
          },
          groupHeaderBuilder: (BuildContext context, int section) {
            String key = _data.keys.toList()[section];
            return (widget as WiseGroupPagedLoadList<T, H>)
                .headerBuilder(_header[key]!);
          },
          sectionSeparatorBuilder: (BuildContext context, int section) {
            return Divider(height: 1);
          },
        ),
      ),
    );
  }

  ///获取数据
  Future<List<T>> _fetchData({int? pageNum}) async {
    Map<String, dynamic> params = Map<String, dynamic>();
    params["page_num"] = pageNum ?? _pageNum;
    params["page_size"] = widget.pageSize;
    if (null != _payload) params.addAll(_payload!);
    return await (widget as WiseGroupPagedLoadList<T, H>).future(params);
  }

  ///上拉加载更多
  Future<bool> _loadMore() async {
    List<T> newData = await _fetchData();
    if (newData.length > 0) {
      _formatterData(newData);
      setState(() {
        _data = _data;
        _pageNum++;
      });
    }
    return newData.length > 0;
  }

  ///格式化
  void _formatterData(List<T> newData) {
    newData.forEach((element) {
      ///获取单条数据的分组数据
      WiseGroupPagedLoadListHeaderData<H> wiseGroupPagedLoadListHeaderData =
          (widget as WiseGroupPagedLoadList<T, H>).group(element);
      if (_data.containsKey(wiseGroupPagedLoadListHeaderData.key)) {
        ///已存在分组数据
        List<T> list = _data[wiseGroupPagedLoadListHeaderData.key]!;
        list.add(element);
      } else {
        ///不存在分组数据
        List<T> list = [];
        list.add(element);
        _data[wiseGroupPagedLoadListHeaderData.key] = list;
        _header[wiseGroupPagedLoadListHeaderData.key] =
            wiseGroupPagedLoadListHeaderData.value;
      }
    });
  }

  ///下拉刷新
  Future<bool> _refresh() async {
    _pageNum = 1;
    List<T> newData = await _fetchData();
    if (newData.length > 0) {
      setState(() {
        _data.clear();
        _header.clear();
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
}
