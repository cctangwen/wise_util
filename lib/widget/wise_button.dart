import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/res/wise_color.dart';
import '/util/screen/screen_size_extension.dart';

class WiseButton {
  ///主要按钮
  static Widget primaryButton(
    String data, {
    required VoidCallback? onPressed,
    double? height,
    double? minWidth,
  }) {
    return MaterialButton(
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: WiseColor.colorPrimary(), width: 1.w),
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      color: WiseColor.colorPrimary(),
      height: height ?? 40.w,
      minWidth: minWidth,
      onPressed: onPressed,
      child: Text(
        data,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontFamily: 'Regular',
        ),
      ),
    );
  }

  ///次要按钮
  static Widget secondButton(
    String data, {
    required VoidCallback? onPressed,
    double? height,
    double? minWidth,
  }) {
    return MaterialButton(
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Get.isDarkMode ? Color(0xFF636366) : Color(0xFFD1D1D6),
            width: 1.w),
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      color: WiseColor.colorNormalBackground(),
      height: height ?? 40.w,
      minWidth: minWidth,
      onPressed: onPressed,
      child: Text(
        data,
        style: TextStyle(
          color: WiseColor.colorPrimary(),
          fontSize: 16.sp,
          fontFamily: 'Regular',
        ),
      ),
    );
  }
}
