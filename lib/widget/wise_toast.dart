import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/res/wise_style.dart';
import 'package:wise_util/util/screen/screen_size_extension.dart';
import 'package:wise_util/widget/wise_box.dart';

enum WiseToastLength { short, normal, long }

class WiseToast {
  ///成功Toast
  static void successToast(BuildContext context, String msg,
      {WiseToastLength toastLength = WiseToastLength.short}) {
    _toast(
      context,
      msg,
      prefix: Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 24.w,
      ),
      toastLength: toastLength,
    );
  }

  ///失败Toast
  static void failToast(BuildContext context, String msg,
      {WiseToastLength toastLength = WiseToastLength.short}) {
    _toast(
      context,
      msg,
      prefix: Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 24.w,
      ),
      toastLength: toastLength,
    );
  }

  ///信息Toast
  static void infoToast(BuildContext context, String msg,
      {WiseToastLength toastLength = WiseToastLength.short}) {
    _toast(
      context,
      msg,
      prefix: Icon(
        Icons.info_outline,
        color: Colors.blue,
        size: 24.w,
      ),
      toastLength: toastLength,
    );
  }

  static void _toast(
    BuildContext context,
    String msg, {
    Widget? prefix,
    required WiseToastLength toastLength,
  }) {
    int duration = 3;
    if (toastLength == WiseToastLength.short) {
      duration = 3;
    } else if (toastLength == WiseToastLength.normal) {
      duration = 5;
    } else if (toastLength == WiseToastLength.long) {
      duration = 7;
    }

    showToastWidget(
      Card(
        margin: EdgeInsets.symmetric(horizontal: 40.w),
        elevation: 4,
        color: WiseColor.colorNormalBackground(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
            child: Wrap(
              spacing: 4.w,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                prefix ?? WiseBox().hBox0,
                Text(
                  msg,
                  style: WiseStyle.textStyleBody(),
                ),
              ],
            )),
      ),
      context: context,
      animation: StyledToastAnimation.slideFromBottom,
      reverseAnimation: StyledToastAnimation.slideToBottom,
      startOffset: Offset(0.0, 3.0),
      reverseEndOffset: Offset(0.0, 3.0),
      position: StyledToastPosition(
        align: Alignment.bottomCenter,
        offset: 60.w,
      ),
      duration: Duration(seconds: duration),
      animDuration: Duration(milliseconds: 350),
    );
  }
}
