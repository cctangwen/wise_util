import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/util/screen/screen_size_extension.dart';

class WiseSnackbar {
  static showSnackbar({
    required String title,
    required String msg,
    int duration = 3,
  }) {
    Get.showSnackbar(GetBar(
      title: title,
      message: msg,
      duration: Duration(seconds: duration),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(16.w),
      borderRadius: 10.r,
    ));
  }
}
