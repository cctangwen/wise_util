import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/widget/wise_multi_state/wise_mulit_state_loading.dart';
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
            loadingWidget: WiseMultiStateLoading(),
            future: () async {
              print("模拟异步操作");
              throw Exception("123123123123");
              await Future.delayed(Duration(seconds: 3));
              return null;
            },
          ),
        );
      },
    );
  }
}
