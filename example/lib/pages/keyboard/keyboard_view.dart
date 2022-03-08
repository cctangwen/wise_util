import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/widget/wise_box.dart';
import 'package:wise_util/widget/wise_button.dart';

import 'keyboard_controller.dart';

class KeyboardPage extends StatelessWidget {
  KeyboardPage({Key? key}) : super(key: key);

  final controller = Get.find<KeyboardController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KeyboardController>(
      assignId: true,
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            controller.closeKeyboard();
            return Future.value(true);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text("keyboard"),
            ),
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      WiseBox().wBox10,
                      Text("ja-JP"),
                      Switch(
                          value: controller.isJaJP(),
                          onChanged: (value) async {
                            print("onChanged:$value");
                            controller.switchToJaJP(value);
                          }),
                    ],
                  ),
                  Row(
                    children: [
                      WiseBox().wBox10,
                      Text("with ok button"),
                      Switch(
                          value: controller.withOKButton,
                          onChanged: (value) async {
                            print("onChanged:$value");
                            controller.switchToOKButton(value);
                          }),
                    ],
                  ),
                  Row(
                    children: [
                      WiseBox().wBox10,
                      Obx(() {
                        return Text("content:${controller.content.value}");
                      }),
                    ],
                  ),
                  WiseButton.secondaryButton("openKeyboard", onPressed: () {
                    controller.openKeyboard(context);
                  }),
                  WiseButton.secondaryButton("closeKeyboard", onPressed: () {
                    controller.closeKeyboard();
                  }),
                  // WiseDigitalKeyboard(
                  //   withOKButton: controller.withOKButton,
                  //   onChange: (content) {
                  //     controller.content.value = content;
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
