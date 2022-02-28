import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/widget/wise_pull_to_refresh.dart';

import 'pull_to_refresh_controller.dart';

class PullToRefreshPage extends StatelessWidget {
  PullToRefreshPage({Key? key}) : super(key: key);

  final controller = Get.find<PullToRefreshController>();

  List<String> list = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PullToRefreshController>(
      assignId: true,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("pull-to-refresh"),
          ),
          body: Container(
            width: Get.width,
            height: Get.height,
            child: WisePullToRefresh(
              enablePullUp: true,
              enablePullDown: true,
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2));
                list = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
                controller.update();
              },
              onLoading: () async {
                await Future.delayed(Duration(seconds: 2));
                list.addAll(["1", "2", "3", "4", "5"]);
                controller.update();
                return Future.value(true);
              },
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: Text(list[index]));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemCount: list.length),
            ),
          ),
        );
      },
    );
  }
}
