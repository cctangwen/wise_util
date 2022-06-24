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

    await WiseLog.init(
        appAlisa: "WiseBoss",
        endpoint: "https://eu-west-1.log.aliyuncs.com",
        project: "k8s-log-ce6e41397056c4e8084434f1bf0c552ff",
        logstore: "wiseboss-app-log");
    WiseLog.addUserTag("我是蒲攀");
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
