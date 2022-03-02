import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/util/screen/screen_size_extension.dart';

class WiseStyle {
  ///显示Display-适配深色模式
  static TextStyle textStyleDisplay() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.87)
          : Color(0xFF000000).withOpacity(0.87),
      fontSize: 32.0.sp,
      fontWeight: FontWeight.w700);

  ///大标题Headline-适配深色模式
  static TextStyle textStyleHeadline() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.87)
          : Color(0xFF000000).withOpacity(0.87),
      fontSize: 24.0.sp,
      fontWeight: FontWeight.w700);

  ///标题Title-适配深色模式
  static TextStyle textStyleTitle() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.87)
          : Color(0xFF000000).withOpacity(0.87),
      fontSize: 20.0.sp,
      fontWeight: FontWeight.w700);

  ///标签Label-适配深色模式
  static TextStyle textStyleLabel() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.87)
          : Color(0xFF000000).withOpacity(0.87),
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w400);

  ///正文Body-适配深色模式
  static TextStyle textStyleBody() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.87)
          : Color(0xFF000000).withOpacity(0.87),
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w400);

  ///次要文本-适配深色模式
  static TextStyle textStyleSecondaryBody() => TextStyle(
      fontFamily: 'Regular',
      color: Get.isDarkMode
          ? Color(0xFFFFFFFF).withOpacity(0.38)
          : Color(0xFF000000).withOpacity(0.38),
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w400);
}
