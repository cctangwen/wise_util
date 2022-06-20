import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wise_util/business/log/wise_log_service.dart';
import 'package:wise_util/util/app_util.dart';
import 'package:wise_util/util/date_util.dart';

///阿里云远程日志服务
class WiseLog {
  static const MethodChannel _channel = const MethodChannel('wise_util');

  static init(
      {required String appAlisa,
      required String endpoint,
      required String project,
      required String logstore}) async {
    await _channel.invokeMethod('init', [
      endpoint,
      project,
      logstore,
      "1111111111",
      "2222222222",
      "3333333333",
      appAlisa
    ]);
    var resp = await WiseLogService.getAccessToken(appAlisa);
    if (null != resp) {
      Map<String, dynamic> credentials = resp['logservice_credentials'];
      await _channel.invokeMethod('init', [
        endpoint,
        project,
        logstore,
        credentials['accessKeyId'],
        credentials['accessKeySecret'],
        credentials['securityToken'],
        appAlisa
      ]);
    }
    addDeviceTag();
  }

  static addUserTag(String user) async {
    var params = Map<String, dynamic>();
    params['user_identification'] = user;
    await _channel.invokeMethod('addTag', params);
  }

  static addDeviceTag() async {
    var params = Map<String, dynamic>();
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (GetPlatform.isIOS) {
      var device = await deviceInfoPlugin.iosInfo;
      params['device_type'] = 'ios';
      params['device_model'] = device.model;
      params['device_os_version'] = device.systemVersion;
    } else {
      var device = await deviceInfoPlugin.androidInfo;
      params['device_type'] = 'android';
      params['device_model'] = device.model;
      params['device_os_version'] = device.version.release;
    }
    params['app_info'] = await AppUtil.appInfo();
    await _channel.invokeMethod('addTag', params);
  }

  static debug(dynamic content) {
    debugPrint(content);
  }

  static info(dynamic content) {
    debugPrint(content);
    var params = Map<String, dynamic>();
    params["time"] = DateUtil.formatDate(DateTime.now());
    params["level"] = "info";
    params["content"] = content;
    _channel.invokeMethod('addLog', params);
  }

  static error(dynamic content) {
    debugPrint(content);
    var params = Map<String, dynamic>();
    params["time"] = DateUtil.formatDate(DateTime.now());
    params["level"] = "error";
    params["content"] = content;
    _channel.invokeMethod('addLog', params);
  }

  static request(dynamic content) {
    debugPrint(content);
    var params = Map<String, dynamic>();
    params["time"] = DateUtil.formatDate(DateTime.now());
    params["level"] = "request";
    params["content"] = content;
    _channel.invokeMethod('addLog', params);
  }
}
