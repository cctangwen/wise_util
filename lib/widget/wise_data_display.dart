import 'package:flutter/material.dart';
import 'package:wise_util/res/wise_style.dart';
import 'package:wise_util/util/screen/screen_size_extension.dart';
import 'package:wise_util/widget/wise_box.dart';
import 'package:wise_util/widget/wise_button.dart';
import 'package:wise_util/widget/wise_divider.dart';

class WiseDataDisplay {
  static Widget buildVerticalData(String label, dynamic content,
      {bool nullHide = true,
        EdgeInsetsGeometry? padding,
        VoidCallback? onPressed}) {
    if (null == content && nullHide) return WiseBox().hBox0;
    return Container(
      padding: padding ?? EdgeInsets.only(left: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WiseBox().hBox12,
          Text(
            label,
            style: WiseStyle.textStyleSmallLabel(),
          ),
          Visibility(
            visible: onPressed == null,
            replacement: WiseButton.textButton(
                null != content ? content.toString() : "-", onPressed: () {
              onPressed!();
            }),
            child: Text(
              null != content ? content.toString() : "-",
              style: WiseStyle.textStyleLargeBody(),
            ),
          ),
          WiseBox().hBox12,
          WiseDivider(),
        ],
      ),
    );
  }

  static Widget buildHorizontalData(String label, dynamic content,
      {bool nullHide = true,
        EdgeInsetsGeometry? padding,
        VoidCallback? onPressed}) {
    if (null == content && nullHide) return WiseBox().hBox0;
    return Container(
      padding: padding ?? EdgeInsets.only(bottom: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: WiseStyle.textStyleSmallLabel(),
          ),
          Visibility(
            visible: onPressed == null,
            replacement: WiseButton.textButton(
                null != content ? content.toString() : "-", onPressed: () {
              onPressed!();
            }),
            child: Text(
              null != content ? content.toString() : "-",
              style: WiseStyle.textStyleSmallBody(),
            ),
          ),
        ],
      ),
    );
  }
}
