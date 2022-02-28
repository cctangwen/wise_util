import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/util/screen/screen_size_extension.dart';

class WiseSnackBar {
  static showSnackBar({
    required String title,
    required String msg,
    int duration = 3,
    Color? backgroundColor,
  }) {
    Get.showSnackbar(GetBar(
      title: title,
      message: msg,
      duration: Duration(seconds: duration),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(16.w),
      borderRadius: 10.r,
      backgroundColor: backgroundColor ?? Color(0xFF303030),
    ));
  }
}
