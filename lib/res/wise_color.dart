import 'dart:ui';

import 'package:get/get.dart';

class WiseColor {
  ///主题颜色
  static Color colorPrimary() => Get.theme.primaryColor;

  ///正常背景颜色
  static Color colorOnSurface() =>
      Get.isDarkMode ? Color(0xFFE2E2E5) : Color(0xFF1A1C1E);

  ///正常背景颜色
  static Color colorSurface() =>
      Get.isDarkMode ? Color(0xFF2C2C2E) : Color(0xFFFFFFFF);

  ///空白背景颜色
  static Color colorOnBackground() =>
      Get.isDarkMode ? Color(0xFFE2E2E5) : Color(0xFF1A1C1E);

  ///空白背景颜色
  static Color colorBackground() =>
      Get.isDarkMode ? Color(0xFF121213) : Color(0xFFF8F8F9);

  ///分割线颜色
  static Color colorSurfaceVariant() =>
      Get.isDarkMode ? Color(0xFF41474D) : Color(0xFFDEE3EA);
}
