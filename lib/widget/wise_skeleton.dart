import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wise_util/widget/wise_box.dart';
import 'package:wise_util/widget/wise_container.dart';

import '/util/screen/screen_size_extension.dart';

///骨架图类型
enum WiseSkeletonType {
  ///网格骨架图
  gridView,

  ///列表骨架图
  listView,

  ///列表骨架图
  listView2,
}

class WiseSkeleton extends StatelessWidget {
  ///骨架图类型;
  final WiseSkeletonType wiseSkeletonType;

  ///网格骨架图宽高比
  final double gridAspectRatio;

  ///横向子组件个数
  final int crossAxisCount;

  ///竖向子组件个数
  final int mainAxisCount;

  WiseSkeleton({
    this.wiseSkeletonType = WiseSkeletonType.gridView,
    this.gridAspectRatio = 1.2,
    this.crossAxisCount = 4,
    this.mainAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: wiseSkeletonType == WiseSkeletonType.gridView
            ? _buildGridSkeleton()
            : _buildListSkeleton(),
        baseColor: Get.isDarkMode ? Colors.white60 : Colors.grey[300]!,
        highlightColor: Get.isDarkMode ? Colors.white38 : Colors.grey[100]!);
  }

  ///构造网格骨架图组件
  Widget _buildGridSkeleton() {
    List<Widget> gridViewChildren = [];
    for (int index = 0; index < mainAxisCount * crossAxisCount; index++) {
      gridViewChildren.add(_buildGridItemSkeleton());
    }
    return GridView.count(
      shrinkWrap: true,
      childAspectRatio: gridAspectRatio,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      children: gridViewChildren,
    );
  }

  ///构造单个网格组件
  Widget _buildGridItemSkeleton() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            color: Get.isDarkMode ? Colors.black : Colors.white,
          ),
          WiseBox().hBox6,
          Container(
            width: 30.w,
            height: 8.w,
            color: Get.isDarkMode ? Colors.black : Colors.white,
          )
        ],
      ),
    );
  }

  ///构造列表骨架图组件
  Widget _buildListSkeleton() {
    return ListView.separated(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: mainAxisCount,
      itemBuilder: (BuildContext context, int index) {
        return wiseSkeletonType == WiseSkeletonType.listView
            ? _buildListItemSkeleton()
            : _buildListItemSkeleton2();
      },
      separatorBuilder: (BuildContext context, int index) {
        return WiseBox().hBox0;
      },
    );
  }

  ///构造单个列表组件
  Widget _buildListItemSkeleton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Colors.black : Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          WiseBox().wBox16,
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 20.w,
                    color: Get.isDarkMode ? Colors.black : Colors.white,
                  ),
                  WiseBox().hBox4,
                  Container(
                    width: 120.w,
                    height: 10.w,
                    color: Get.isDarkMode ? Colors.black : Colors.white,
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  ///构造单个列表组件2
  Widget _buildListItemSkeleton2() {
    return WiseContainer(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.w),
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.w, top: 12.w),
      color: Get.isDarkMode ? Colors.black38 : Colors.white38,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Colors.black : Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          WiseBox().wBox16,
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 20.w,
                    color: Get.isDarkMode ? Colors.black : Colors.white,
                  ),
                  WiseBox().hBox4,
                  Container(
                    width: 120.w,
                    height: 10.w,
                    color: Get.isDarkMode ? Colors.black : Colors.white,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
