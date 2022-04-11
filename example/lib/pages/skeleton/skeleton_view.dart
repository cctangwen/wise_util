import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/res/wise_style.dart';
import 'package:wise_util/util/screen/screen_size_extension.dart';
import 'package:wise_util/widget/wise_box.dart';
import 'package:wise_util/widget/wise_skeleton.dart';

import 'skeleton_controller.dart';

class SkeletonPage extends StatelessWidget {
  SkeletonPage({Key? key}) : super(key: key);

  final controller = Get.find<SkeletonController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SkeletonController>(
      assignId: true,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Skeleton"),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "grid skeleton",
                style: WiseStyle.textStyleLargeTitle(),
              ),
              Container(
                  margin: EdgeInsets.all(16.w),
                  color: WiseColor.colorSurface(),
                  child: WiseSkeleton(
                    wiseSkeletonType: WiseSkeletonType.gridView,
                    gridAspectRatio: 1.2,
                    mainAxisCount: 2,
                    crossAxisCount: 4,
                  )),
              WiseBox().hBox20,
              Text(
                "list skeleton",
                style: WiseStyle.textStyleLargeTitle(),
              ),
              Container(
                  margin: EdgeInsets.all(16.w),
                  height: 210.w,
                  color: WiseColor.colorSurface(),
                  child: WiseSkeleton(
                    wiseSkeletonType: WiseSkeletonType.listView,
                    mainAxisCount: 10,
                  )),
            ],
          ),
        );
      },
    );
  }
}
