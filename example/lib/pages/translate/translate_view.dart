import 'package:example/pages/translate/translate_test_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/business/translate/wise_translate_text.dart';
import 'package:wise_util/widget/wise_button.dart';

import 'translate_controller.dart';

class TranslatePage extends StatelessWidget {
  TranslatePage({Key? key}) : super(key: key);

  final controller = Get.find<TranslateController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TranslateController>(
      assignId: true,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: WiseTranslateText(
              "Translate",
              wordKey: "translate",
            ),
          ),
          body: Column(
            children: [
              Obx(() {
                return Text(controller.rxCountDownTime.value.toString());
              }),
              TranslateTestWidget(
                  initValue: "countDownTime:${controller.countDownTime}"),
              WiseButton.primaryButton(
                  "countDownTime:${controller.countDownTime}",
                  wordKey: "daasd",
                  onPressed: () {}),
              WiseButton.primaryButton(
                  "countDownTime:${controller.countDownTime}",
                  onPressed: () {}),
              WiseButton.primaryButton("daasd",
                  wordKey: "daasd", onPressed: null),
            ],
          ),
        );
      },
    );
  }
}
