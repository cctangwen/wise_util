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
              "超大号标题48",
              style: WiseStyle.textStyleSuperLargeTitle(),
            ),
            Text(
              "大号标题34",
              style: WiseStyle.textStyleLargeTitle(),
            ),
            Text(
              "正常标题24",
              style: WiseStyle.textStyleNormalTitle(),
            ),
            Text(
              "中号标题20",
              style: WiseStyle.textStyleMediumTitle(),
            ),
            Text(
              "小号标题16",
              style: WiseStyle.textStyleSmallTitle(),
            ),
            Text(
              "主要文本16",
              style: WiseStyle.textStylePrimaryText(),
            ),
            Text(
              "加粗文本16",
              style: WiseStyle.textStyleBoldPrimaryText(),
            ),
            Text(
              "次要文本12",
              style: WiseStyle.textStyleSecondText(),
            ),
          ],
        ),
      ),
    );
  }
}
