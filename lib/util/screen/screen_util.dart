import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ScreenUtil {
  ///默认设计稿尺寸
  static const Size defaultSize = Size(360, 780);

  ///单例对象
  static late ScreenUtil _instance;

  /// UI设计中手机尺寸 , dp
  late Size uiSize;

  late BuildContext context;

  ScreenUtil._();

  factory ScreenUtil() {
    return _instance;
  }

  static void init(BuildContext context,{Size designSize = defaultSize}) {
    _instance = ScreenUtil._();
    _instance.uiSize = designSize;
    _instance.context=context;
  }


  ///每个逻辑像素的字体像素数，字体的缩放比例
  double get textScaleFactor => MediaQuery.of(context).textScaleFactor;

  ///设备的像素密度
  double get pixelRatio => MediaQuery.of(context).devicePixelRatio;

  ///当前设备宽度
  double get screenWidth => MediaQuery.of(context).size.width;

  ///当前设备高度
  double get screenHeight => MediaQuery.of(context).size.height;

  ///状态栏高度
  double get statusBarHeight => MediaQuery.of(context).padding.top;

  ///底部安全区距离
  double get bottomBarHeight => MediaQuery.of(context).padding.bottom;

  ///实际尺寸与UI设计的宽度比例
  double get scaleWidth => screenWidth / uiSize.width;

  ///实际尺寸与UI设计的高度比例
  double get scaleHeight => screenHeight / uiSize.height;

  ///文本缩放比，取宽高比例最小值
  double get scaleText => min(scaleWidth, scaleHeight);

  /// 根据UI设计的设备宽度适配
  double setWidth(num width) => width * scaleWidth;

  /// 根据UI设计的设备高度适配
  double setHeight(num height) => height * scaleHeight;

  ///根据宽度或高度中的较小值进行适配
  double radius(num r) => r * min(scaleWidth, scaleHeight);

  ///字体大小适配方法
  double setSp(num fontSize) => fontSize * scaleText;
}
