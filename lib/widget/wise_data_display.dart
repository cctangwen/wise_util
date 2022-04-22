import 'package:flutter/material.dart';
import 'package:wise_util/res/wise_style.dart';
import 'package:wise_util/util/screen/screen_size_extension.dart';
import 'package:wise_util/widget/wise_box.dart';
import 'package:wise_util/widget/wise_divider.dart';

class WiseDataDisplay {
  static Widget buildVerticalData(String label, dynamic content,
      {bool nullHide = true}) {
    if (null == content && nullHide) return WiseBox().hBox0;
    return Container(
      padding: EdgeInsets.only(left: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WiseBox().hBox12,
          Text(
            label,
            style: WiseStyle.textStyleSmallLabel(),
          ),
          Text(
            content!.toString() ?? "-",
            style: WiseStyle.textStyleLargeBody(),
          ),
          WiseBox().hBox12,
          WiseDivider(),
        ],
      ),
    );
  }
}
