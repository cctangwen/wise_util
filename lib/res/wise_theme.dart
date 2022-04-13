import 'package:flutter/material.dart';

//浅色模式主题样式
ThemeData getLightThemeData(Color primaryColor) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Color(0xFFF8F8F9),
    appBarTheme: _getLightAppBarTheme(),
  );
}

//深色模式主题样式
ThemeData getDarkThemeData(Color primaryColor) {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF121213),
    primaryColor: primaryColor,
    appBarTheme: _getDarkAppBarTheme(),
  );
}

//浅色模式下AppBar的样式
AppBarTheme _getLightAppBarTheme() {
  return AppBarTheme(
    color: Color(0xFFF8F8F9),
    elevation: 0,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline6: TextStyle(
          color: Color(0xFF1A1C1E), fontSize: 20, fontWeight: FontWeight.w600),
    ),
    iconTheme: IconThemeData(color: Color(0xFF1A1C1E)),
  );
}

//深色模式下AppBar的样式
AppBarTheme _getDarkAppBarTheme() {
  return AppBarTheme(
    color: Color(0xFF121213),
    elevation: 0,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headline6: TextStyle(
          color: Color(0xFFFFFFFF), fontSize: 20, fontWeight: FontWeight.w600),
    ),
    iconTheme: IconThemeData(color: Color(0xFFE2E2E5)),
  );
}
