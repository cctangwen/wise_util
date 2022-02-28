import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/widget/wise_multi_state/wise_multi_state_widget.dart';

import 'multi_state_controller.dart';

class MultiStatePage extends StatelessWidget {
  MultiStatePage({Key? key}) : super(key: key);

  final controller = Get.find<MultiStateController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MultiStateController>(
      assignId: true,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('multi state'),
          ),
          body: WiseMultiStateWidget(
            successWidget: Text("load success"),
            future: () async {
              print("模拟异步操作");
              await Future.delayed(Duration(seconds: 3));
              return null;
            },
          ),
        );
      },
    );
  }
}
