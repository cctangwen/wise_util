import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wise_util/config/wise_config.dart';
import 'package:wise_util/util/http/http_manager.dart';

class AppTranslateService {
  ///项目名称
  static String? _projectName;

  ///是否支持翻译
  static bool _supportTranslate = false;

  static void setProjectName(String name) {
    _projectName = name;
  }

  static void setSupportTranslate(bool value) {
    _supportTranslate = value;
  }

  static bool getSupportTranslate() {
    return _supportTranslate;
  }

  ///提交翻译词汇
  static Future<bool> submitWord(
      String wordKey, String newValue, String oldValue) async {
    final HttpManager httpManager = Get.find<HttpManager>();
    String api = kReleaseMode
        ? "https://gw.paycloud.world/bis/mp/app/word/add"
        : "https://gw.wisepaycloud.com/bis/mp/app/word/add";
    final Map<String, dynamic> params = Map<String, dynamic>();
    params["project_name"] = _projectName;
    params["word_path"] = Get.currentRoute;
    params["word_language"] = WiseConfig.getLanguage();
    final Map<String, dynamic> word = Map<String, dynamic>();
    word["word_key"] = wordKey;
    word["word_val"] = newValue;
    word["word_origin_val"] = oldValue;
    params["word_json"] = [word];
    var resp =
        await httpManager.post(api, params: params, withLoadingHint: false);
    return resp.isSuccess;
  }
}
