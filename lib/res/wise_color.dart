import 'dart:ui';

import 'package:get/get.dart';

class WiseColor {
  ///主题颜色
  static Color colorPrimary() => Get.theme.primaryColor;

  static Color colorPrimaryContainer() =>
      Get.isDarkMode ? Color(0xFF004B72) : Color(0xFFC9E6FF);

  static Color colorOnPrimaryContainer() =>
      Get.isDarkMode ? Color(0xFFC9E6FF) : Color(0xFF001E31);

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
      Get.isDarkMode ? Color(0xFF1C1C1E) : Color(0xFFF2F2F7);

  ///分割线颜色
  static Color colorSurfaceVariant() =>
      Get.isDarkMode ? Color(0xFF41474D) : Color(0xFFDEE3EA);
}
