import 'dart:ui';

import 'package:get/get.dart';

class WiseColor {
  ///主题颜色
  static Color colorPrimary() => Get.theme.primaryColor;

  ///正常背景颜色
  static Color colorNormalBackground() =>
      Get.isDarkMode ? Color(0xFF2C2C2E) : Color(0xFFFFFFFF);

  ///空白背景颜色
  static Color colorBlankBackground() =>
      Get.isDarkMode ? Color(0xFF121213) : Color(0xFFEEEEEE);
}
