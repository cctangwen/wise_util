import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/res/wise_style.dart';
import 'package:wise_util/widget/wise_box.dart';

import '/res/wise_color.dart';
import '/util/screen/screen_size_extension.dart';

///按钮
class WiseButton {
  ///主要按钮
  static Widget primaryButton(
    String data, {
    required VoidCallback? onPressed,
    double? height,
    double? minWidth,
    IconData? icon,
  }) {
    return MaterialButton(
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.r)),
      ),
      disabledColor: WiseColor.colorSurfaceVariant(),
      color: WiseColor.colorPrimary(),
      height: height ?? 40.w,
      minWidth: minWidth,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Icon(
                    icon,
                    size: 20.w,
                    color: Colors.white,
                  ),
                )
              : WiseBox().hBox0,
          Text(
            data,
            style: WiseStyle.textStyleLargeBody().copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  ///次要按钮
  static Widget secondaryButton(
    String data, {
    required VoidCallback? onPressed,
    double? height,
    double? minWidth,
    IconData? icon,
  }) {
    return MaterialButton(
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Get.isDarkMode ? Color(0xFF636366) : Color(0xFFD1D1D6),
            width: 1.w),
        borderRadius: BorderRadius.all(Radius.circular(24.r)),
      ),
      color: WiseColor.colorSurface(),
      height: height ?? 40.w,
      minWidth: minWidth,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Icon(
                    icon,
                    size: 20.w,
                    color: Colors.white,
                  ),
                )
              : WiseBox().hBox0,
          Text(
            data,
            style: WiseStyle.textStyleLargeBody()
                .copyWith(color: WiseColor.colorPrimary()),
          ),
        ],
      ),
    );
  }

  ///文本按钮
  static Widget textButton(
    String data, {
    required VoidCallback? onPressed,
    EdgeInsetsGeometry? padding,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          data,
          style: TextStyle(
            color: textColor ?? WiseColor.colorPrimary(),
            fontSize: 14.sp,
            fontFamily: 'Regular',
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
