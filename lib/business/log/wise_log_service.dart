import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wise_util/util/http/http_manager.dart';

class WiseLogService {
  ///获取getAccessToken
  static Future<Map<String, dynamic>?> getAccessToken(String appName) async {
    final HttpManager httpManager = Get.find<HttpManager>();
    String api = kReleaseMode
        ? "https://gw.paycloud.world/pbs/common/logservice/getAccessToken"
        : "https://gw.wisepaycloud.com/pbs/common/logservice/getAccessToken";
    final Map<String, dynamic> params = Map<String, dynamic>();
    params["app_alias"] = appName;
    var resp =
        await httpManager.post(api, params: params, withLoadingHint: false);
    if (resp.isSuccess) return resp.data;
  }
}
