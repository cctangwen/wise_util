import 'package:flutter/material.dart';

import '/util/screen/screen_size_extension.dart';

///空盒子，占位使用
class WiseBox {
  WiseBox._privateConstructor();

  static final WiseBox _instance = WiseBox._privateConstructor();

  factory WiseBox() {
    return _instance;
  }

  ///宽
  final Widget wBox4 = SizedBox(width: 4.w);
  final Widget wBox6 = SizedBox(width: 6.w);
  final Widget wBox8 = SizedBox(width: 8.w);
  final Widget wBox10 = SizedBox(width: 10.w);
  final Widget wBox16 = SizedBox(width: 16.w);
  final Widget wBox20 = SizedBox(width: 20.w);
  final Widget wBox30 = SizedBox(width: 30.w);
  final Widget wBox50 = SizedBox(width: 50.w);

  ///高
  final Widget hBox0 = SizedBox.shrink();
  final Widget hBox4 = SizedBox(height: 4.w);
  final Widget hBox6 = SizedBox(height: 6.w);
  final Widget hBox8 = SizedBox(height: 8.w);
  final Widget hBox10 = SizedBox(height: 10.w);
  final Widget hBox12 = SizedBox(height: 12.w);
  final Widget hBox14 = SizedBox(height: 14.w);
  final Widget hBox16 = SizedBox(height: 16.w);
  final Widget hBox18 = SizedBox(height: 18.w);
  final Widget hBox20 = SizedBox(height: 20.w);
  final Widget hBox24 = SizedBox(height: 24.w);
  final Widget hBox30 = SizedBox(height: 30.w);
  final Widget hBox36 = SizedBox(height: 36.w);
  final Widget hBox40 = SizedBox(height: 40.w);
  final Widget hBox50 = SizedBox(height: 50.w);
  final Widget hBox60 = SizedBox(height: 60.w);
  final Widget hBox80 = SizedBox(height: 80.w);
  final Widget hBox108 = SizedBox(height: 108.w);
  final Widget hBox120 = SizedBox(height: 120.w);
  final Widget hBox180 = SizedBox(height: 180.w);
  final Widget hBox200 = SizedBox(height: 200.w);
}
