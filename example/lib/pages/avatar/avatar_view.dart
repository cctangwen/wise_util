import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/res/wise_style.dart';
import 'package:wise_util/widget/wise_avatar.dart';
import 'package:wise_util/widget/wise_box.dart';

import 'avatar_controller.dart';

class AvatarPage extends StatelessWidget {
  AvatarPage({Key? key}) : super(key: key);

  final controller = Get.find<AvatarController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
      assignId: true,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Avatar"),
          ),
          body: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("网络图片(正常):", style: WiseStyle.textStyleLargeLabel()),
                    WiseAvatar(
                        size: 100,
                        src:
                            "https://img2.baidu.com/it/u=1454761046,2213546903&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500"),
                  ],
                ),
                WiseBox().hBox20,
                Row(
                  children: [
                    Text("网络图片(正常):", style: WiseStyle.textStyleLargeLabel()),
                    WiseAvatar(
                        src:
                            "https://img2.baidu.com/it/u=1454761046,2213546903&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500"),
                  ],
                ),
                WiseBox().hBox20,
                Row(
                  children: [
                    Text("网络图片(异常):", style: WiseStyle.textStyleLargeLabel()),
                    WiseAvatar(src: ""),
                  ],
                ),
                WiseBox().hBox20,
                Row(
                  children: [
                    Text("文本头像:", style: WiseStyle.textStyleLargeLabel()),
                    WiseAvatar(
                      alt: "PP",
                      backgroundColor: Colors.green,
                    ),
                  ],
                ),
                WiseBox().hBox20,
                Row(
                  children: [
                    Text("Icon头像:", style: WiseStyle.textStyleLargeLabel()),
                    WiseAvatar(
                      icon: Icon(
                        Icons.storefront,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
