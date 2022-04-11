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
        color: WiseColor.colorSurface(),
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Display Small - 36",
              style: WiseStyle.textStyleDisplay(),
            ),
            Text(
              "Headline Small - 24",
              style: WiseStyle.textStyleHeadline(),
            ),
            Text(
              "Title Large - Medium 20",
              style: WiseStyle.textStyleLargeTitle(),
            ),
            Text(
              "Title Medium - Medium 16 . +0.15",
              style: WiseStyle.textStyleMediumTitle(),
            ),
            Text(
              "Title Small - Medium 14 . +0.1",
              style: WiseStyle.textStyleSmallTitle(),
            ),
            Text(
              "Body Large - Regular 16 . +0.15",
              style: WiseStyle.textStyleLargeBody(),
            ),
            Text(
              "Body Medium - Regular 14 . +0.25",
              style: WiseStyle.textStyleMediumBody(),
            ),
            Text(
              "Body Small - Regular 12 . +0.4",
              style: WiseStyle.textStyleSmallBody(),
            ),
            Text(
              "Label Large - Medium 16 . +0.1",
              style: WiseStyle.textStyleLargeLabel(),
            ),
            Text(
              "Label Medium - Medium 14 . +0.1",
              style: WiseStyle.textStyleMediumLabel(),
            ),
            Text(
              "Label Small - Medium 12 . +0.1",
              style: WiseStyle.textStyleSmallLabel(),
            ),
          ],
        ),
      ),
    );
  }
}
