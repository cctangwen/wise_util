import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/business/log/wise_log.dart';
import 'package:wise_util/business/translate/wise_translate_service.dart';
import 'package:wise_util/util/http/http_manager.dart';

class HomeController extends GetxController {
  final HttpManager _httpManager = Get.find<HttpManager>();

  @override
  void onReady() async {
    super.onReady();
    _httpManager.setLoginPageAlisa("/style");
    _httpManager.addTokenInterceptor(
        "https://gw.paycloud.world/wallet/ucs/app/user/login");
    AppTranslateService.setProjectName("WiseBoss");
    AppTranslateService.setSupportTranslate(true);

    await WiseLog.init("WiseBoss");
    WiseLog.addTag("123123123123");
  }

  switchTheme() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      print("Get.changeThemeMode(ThemeMode.light)");
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      print("Get.changeThemeMode(ThemeMode.dark)");
    }
    Future.delayed(Duration(milliseconds: 500), () {
      update();
    });
  }

  sendHttpRequest() async {
    var resp = await _httpManager
        .post("https://gw.paycloud.world/wallet/ucs/app/user/login");
    print(resp.isSuccess);
    print(resp.msg);
    print(resp.data);
    print(resp.code);
  }
}
