import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_utils/src/platform/platform.dart';

import '/business/update/app_update_dialog.dart';
import '/util/app_util.dart';
import '/util/http/http_manager.dart';

///应用升级服务
class AppUpdateService {
  ///检查应用版本信息
  static Future<bool> checkUpdate(
      {bool showDialog = true, showLoading = false}) async {
    final HttpManager httpManager = Get.find<HttpManager>();
    String api = kReleaseMode
        ? "https://gw.paycloud.world/ims/mp/app/mobile/app/version/update"
        : "https://gw.wisepaycloud.com/ims/mp/app/mobile/app/version/update";
    final Map<String, dynamic> params = Map<String, dynamic>();
    if (GetPlatform.isIOS) {
      params["system_type"] = "ios";
      params["packagename_ios"] = await AppUtil.appPackageName();
    }
    if (GetPlatform.isAndroid) {
      params["system_type"] = "android";
      params["packagename_android"] = await AppUtil.appPackageName();
    }
    params["system_type"] = GetPlatform.isAndroid ? "android" : "ios";
    params["app_name"] = await AppUtil.appName();
    var resp = await httpManager.post(api,
        params: params,
        withErrorHint: showLoading,
        withLoadingHint: showLoading);
    try {
      ///发现新版本
      if (resp.isSuccess &&
          null != resp.data["version_num"] &&
          int.parse(resp.data["version_num"].toString()) >
              await AppUtil.appBuildNumber()) {
        if (showDialog) {
          Map<String, dynamic> address = {};
          try {
            ///获取后台地址字段中的ios_app_id值
            address = convert.jsonDecode(resp.data["address"]);
          } catch (e) {}

          Get.dialog(
              AppUpdateDialog(
                isForceUpdate: resp.data["force_update"].toString() == "0",
                description: resp.data["description"],
                iosAppId: address["ios_app_id"],
                androidAppId: address["android_app_id"],
                h5DownloadUrl: address["h5_download_url"],
              ),
              barrierDismissible: false);
        }
        return true;
      }
    } catch (e) {
      print("update data parse exception:$e");
    }
    return false;
  }
}
