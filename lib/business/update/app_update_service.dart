import 'dart:convert' as convert;
import 'dart:io';

import 'package:app_installer/app_installer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '/business/update/app_update_dialog.dart';
import '/res/wise_localizations.dart';
import '/util/app_util.dart';
import '/util/http/http_manager.dart';
import '/util/permission_util.dart';

class AppUpdateService {
  ///检查应用版本信息
  static Future<bool> checkUpdate({bool showDialog = true}) async {
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
        params: params, withErrorHint: false, withLoadingHint: false);
    try {
      ///发现新版本
      if (resp.isSuccess &&
          null != resp.data["version_num"] &&
          int.parse(resp.data["version_num"].toString()) >
              await AppUtil.appBuildNumber()) {
        if (showDialog) {
          String? iosAppId;
          try {
            ///获取后台地址字段中的ios_app_id值
            iosAppId = convert.jsonDecode(resp.data["address"])["ios_app_id"];
          } catch (e) {}

          Get.dialog(
              AppUpdateDialog(
                isForceUpdate: resp.data["force_update"].toString() == "1",
                description: resp.data["description"],
                fileKey: resp.data["file_name"],
                iosAppId: iosAppId,
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

  static Future<void> androidUpdate(
      String fileKey, Function(int, int) onReceiveProgress) async {
    WiseString strings =
        WiseLocalizations.of(Get.context!)?.currentLocalization ??
            EnWiseString();

    ///检查存储权限
    bool hasStoragePermission = await PermissionUtil.checkPermission(
        Permission.storage,
        Get.context!,
        strings.requestStoragePermissionToDownload);
    if (!hasStoragePermission) {
      return null;
    }

    /// 创建存储文件
    Directory? storageDir = await getExternalStorageDirectory();
    String storagePath = storageDir!.path;
    String fileName =
        "$storagePath/${DateTime.now().millisecondsSinceEpoch}.apk";
    File file = new File(fileName);
    print("filePath:${file.path}");
    if (!file.existsSync()) {
      file.createSync();
    }

    ///下载应用包
    String url = kReleaseMode
        ? "https://gw.paycloud.world/bis/sc/file/download/$fileKey"
        : "https://gw.wisepaycloud.com/bis/sc/file/download/$fileKey";
    try {
      /// 发起下载请求
      Response response = await Dio().get(
        url,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );
      file.writeAsBytesSync(response.data);
      AppInstaller.installApk(fileName);
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// "1582773616"
  static void iosUpdate(String iosAppId) async {
    ///跳转到IOS应用市场
    AppInstaller.goStore(await AppUtil.appPackageName(), iosAppId);
  }
}
