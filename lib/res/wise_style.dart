import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/util/screen/screen_size_extension.dart';

class WiseStyle {
  ///超大号标题-适配深色模式
  static TextStyle textStyleSuperLargeTitle() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.87)
          : Color(0xFF000000).withOpacity(0.87),
      fontSize: 48.0.sp,
      fontWeight: FontWeight.w700);

  ///大号标题-适配深色模式
  static TextStyle textStyleLargeTitle() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.87)
          : Color(0xFF000000).withOpacity(0.87),
      fontSize: 34.0.sp,
      fontWeight: FontWeight.w700);

  ///正常标题-适配深色模式
  static TextStyle textStyleNormalTitle() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.87)
          : Color(0xFF000000).withOpacity(0.87),
      fontSize: 24.0.sp,
      fontWeight: FontWeight.w700);

  ///中号标题-适配深色模式
  static TextStyle textStyleMediumTitle() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.87)
          : Color(0xFF000000).withOpacity(0.87),
      fontSize: 20.0.sp,
      fontWeight: FontWeight.w700);

  ///小号标题-适配深色模式
  static TextStyle textStyleSmallTitle() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.87)
          : Color(0xFF000000).withOpacity(0.87),
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w700);

  ///文本-适配深色模式
  static TextStyle textStylePrimaryText() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.87)
          : Color(0xFF000000).withOpacity(0.87),
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w400);

  ///加粗文本-适配深色模式
  static TextStyle textStyleBoldPrimaryText() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.87)
          : Color(0xFF000000).withOpacity(0.87),
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w800);

  ///副文本-适配深色模式
  static TextStyle textStyleSecondText() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.38)
          : Color(0xFF000000).withOpacity(0.38),
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w400);
}
