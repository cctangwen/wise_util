import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '/res/wise_color.dart';
import '/res/wise_localizations.dart';
import '/res/wise_style.dart';
import '/util/screen/screen_size_extension.dart';

///下拉刷新组件
class WisePullToRefresh extends StatefulWidget {
  ///是否允许下拉刷新
  final bool enablePullDown;

  ///是否允许上拉加载更多
  final bool enablePullUp;

  ///下拉刷新回调
  final Function()? onRefresh;

  ///上拉加载更多回调
  ///返回true，表示加载完成
  ///返回false，表示没有更多数据了
  ///抛出异常，表示加载失败
  final Future<bool> Function()? onLoading;

  ///[ListView]必须是唯一子组件，普通组件需要使用[CustomScrollView]+[SliverToBoxAdapter]
  final Widget child;

  final bool usePrimary;

  WisePullToRefresh({
    required this.child,
    this.enablePullUp = false,
    this.enablePullDown = true,
    this.onRefresh,
    this.onLoading,
    this.usePrimary = false,
  });

  @override
  State<StatefulWidget> createState() => _WisePullToRefreshState();
}

class _WisePullToRefreshState extends State<WisePullToRefresh> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    WiseString strings =
        WiseLocalizations.of(context)?.currentLocalization ?? EnWiseString();
    Color iconColor =
        widget.usePrimary ? Colors.white : WiseColor.colorPrimary();
    return SmartRefresher(
      controller: _refreshController,
      header: TwoLevelHeader(
        textStyle: widget.usePrimary
            ? WiseStyle.textStyleMediumBody().copyWith(color: Colors.white)
            : WiseStyle.textStyleMediumBody(),
        completeIcon: Icon(Icons.done, color: iconColor),
        idleIcon: Icon(Icons.arrow_downward, color: iconColor),
        releaseIcon: Icon(Icons.refresh, color: iconColor),
        failedIcon: Icon(Icons.error, color: Colors.redAccent),
        releaseText: strings.refreshRelease,
        refreshingText: strings.refreshRefreshing,
        failedText: strings.refreshFailed,
        completeText: strings.refreshCompleted,
        idleText: strings.refreshIdle,
        refreshingIcon: Container(
          width: 20.w,
          height: 20.w,
          child: CircularProgressIndicator(color: iconColor, strokeWidth: 2),
        ),
        decoration: BoxDecoration(
          color: widget.usePrimary
              ? WiseColor.colorPrimary()
              : WiseColor.colorBackground(),
        ),
      ),
      footer: ClassicFooter(
        textStyle: WiseStyle.textStyleMediumBody(),
        idleIcon: Icon(Icons.arrow_upward, color: WiseColor.colorPrimary()),
        canLoadingIcon: Icon(Icons.refresh, color: WiseColor.colorPrimary()),
        failedIcon: Icon(Icons.error, color: Colors.redAccent),
        loadingText: strings.refreshLoadLoading,
        noDataText: strings.refreshLoadNoData,
        failedText: strings.refreshLoadFail,
        idleText: strings.refreshLoadIdle,
        canLoadingText: strings.refreshLoadCanLoading,
      ),
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: widget.child,
    );
  }

  ///下拉刷新回调
  void _onRefresh() async {
    try {
      if (null != widget.onRefresh) await widget.onRefresh!();
      _refreshController.refreshCompleted();
    } catch (e) {
      print("_onRefresh error:$e");
      _refreshController.refreshFailed();
    }
  }

  ///上拉加载更多回调
  void _onLoading() async {
    try {
      bool hasData = true;
      if (null != widget.onLoading) hasData = await widget.onLoading!();
      if (hasData) {
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
    } catch (e) {
      print("_onLoading error:$e");
      _refreshController.loadFailed();
    }
  }
}
