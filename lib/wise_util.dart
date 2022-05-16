import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;

import '/util/http/http_manager.dart';
import '/util/screen/screen_util.dart';
import '/util/sp_util.dart';

class WiseUtil {
  ///初始化依赖
  static Future<void> initDependency() async {
    ///初始化SP
    await SpUtil.getInstance();

    ///注入HttpManager
    Get.put(HttpManager());

    tz.initializeTimeZones();
  }

  ///屏幕适配初始化
  static void initScreen(BuildContext context) {
    ScreenUtil.init(context);
  }
}
