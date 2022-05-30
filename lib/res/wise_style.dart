import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/util/screen/screen_size_extension.dart';

class WiseStyle {
  ///显示Display-适配深色模式
  static TextStyle textStyleDisplay() => TextStyle(
      fontFamily: 'Medium',
      color: Get.isDarkMode ? Color(0xFFE2E2E5) : Color(0xFF1A1C1E),
      fontSize: 36.0.sp,
      fontWeight: FontWeight.w600);

  ///大标题Headline-适配深色模式
  static TextStyle textStyleHeadline() => TextStyle(
      fontFamily: 'Medium',
      color: Get.isDarkMode ? Color(0xFFE2E2E5) : Color(0xFF1A1C1E),
      fontSize: 24.0.sp,
      fontWeight: FontWeight.w500);

  ///大号标题Title-适配深色模式
  static TextStyle textStyleLargeTitle() => TextStyle(
      fontFamily: 'Medium',
      color: Get.isDarkMode ? Color(0xFFE2E2E5) : Color(0xFF1A1C1E),
      fontSize: 20.0.sp,
      fontWeight: FontWeight.w500);

  ///中号标题Title-适配深色模式
  static TextStyle textStyleMediumTitle() => TextStyle(
      fontFamily: 'Medium',
      color: Get.isDarkMode ? Color(0xFFE2E2E5) : Color(0xFF1A1C1E),
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w500);

  ///小号标题Title-适配深色模式
  static TextStyle textStyleSmallTitle() => TextStyle(
      fontFamily: 'Medium',
      color: Get.isDarkMode ? Color(0xFFE2E2E5) : Color(0xFF1A1C1E),
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500);

  ///大号正文Body-适配深色模式
  static TextStyle textStyleLargeBody() => TextStyle(
      fontFamily: 'Medium',
      color: Get.isDarkMode ? Color(0xFFE2E2E5) : Color(0xFF1A1C1E),
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w400);

  ///大号正文Body-适配深色模式-禁用
  static TextStyle textStyleLargeBodyDisabled() =>
      textStyleLargeBody().copyWith(
        color: Get.isDarkMode
            ? Color(0xFFE2E2E5).withOpacity(0.38)
            : Color(0xFF1A1C1E).withOpacity(0.38),
      );

  ///中号正文Body-适配深色模式
  static TextStyle textStyleMediumBody() => TextStyle(
      fontFamily: 'Medium',
      color: Get.isDarkMode ? Color(0xFFE2E2E5) : Color(0xFF1A1C1E),
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w400);

  ///小号正文Body-适配深色模式
  static TextStyle textStyleSmallBody() => TextStyle(
      fontFamily: 'Medium',
      color: Get.isDarkMode ? Color(0xFFE2E2E5) : Color(0xFF1A1C1E),
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w400);

  ///大号标签Label-适配深色模式
  static TextStyle textStyleLargeLabel() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode ? Color(0xFF8B9198) : Color(0xFF41474D),
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w400);

  ///大号正文Body-适配深色模式-禁用
  static TextStyle textStyleLargeLabelDisabled() =>
      textStyleLargeLabel().copyWith(
        color: Get.isDarkMode
            ? Color(0xFF8B9198).withOpacity(0.38)
            : Color(0xFF41474D).withOpacity(0.38),
      );

  ///中号标签Label-适配深色模式
  static TextStyle textStyleMediumLabel() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode ? Color(0xFF8B9198) : Color(0xFF41474D),
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w400);

  ///小号标签Label-适配深色模式
  static TextStyle textStyleSmallLabel() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode ? Color(0xFF8B9198) : Color(0xFF41474D),
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w400);
}
