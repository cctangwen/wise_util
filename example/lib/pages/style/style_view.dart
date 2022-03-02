import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/res/wise_style.dart';

class StylePage extends StatelessWidget {
  StylePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Style Example"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: WiseColor.colorNormalBackground(),
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "显示Display32",
              style: WiseStyle.textStyleDisplay(),
            ),
            Text(
              "大标题Headline24",
              style: WiseStyle.textStyleHeadline(),
            ),
            Text(
              "标题Title20",
              style: WiseStyle.textStyleTitle(),
            ),
            Text(
              "标签Label16",
              style: WiseStyle.textStyleLabel(),
            ),
            Text(
              "正文Body14",
              style: WiseStyle.textStyleBody(),
            ),
            Text(
              "次要文本12",
              style: WiseStyle.textStyleSecondaryBody(),
            ),
          ],
        ),
      ),
    );
  }
}
