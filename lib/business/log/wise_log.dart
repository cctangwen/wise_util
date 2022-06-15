import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wise_util/business/log/wise_log_service.dart';
import 'package:wise_util/util/date_util.dart';

///阿里云远程日志服务
class WiseLog {
  static const MethodChannel _channel = const MethodChannel('wise_util');

  static bool _initSuccess = false;

  static init(String appAlisa) async {
    if (_initSuccess) return;
    var resp = await WiseLogService.getAccessToken(appAlisa);
    if (null != resp) {
      Map<String, dynamic> credentials = resp['logservice_credentials'];
      await _channel.invokeMethod('init', [
        credentials['endpoint'],
        credentials['project'],
        credentials['logstore'],
        credentials['accessKeyId'],
        credentials['accessKeySecret'],
        credentials['securityToken'],
        appAlisa
      ]);
      _initSuccess = true;
    }
  }

  static addTag(String? user) async {
    var params = Map<String, dynamic>();
    params['user_identification'] = user;
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
    await _channel.invokeMethod('addTag', params);
  }

  static debug(dynamic content) {
    debugPrint(content);
  }

  static info(dynamic content) {
    debugPrint(content);
    if (!_initSuccess) return;
    var params = Map<String, dynamic>();
    params["time"] = DateUtil.formatDate(DateTime.now());
    params["level"] = "info";
    params["content"] = content;
    _channel.invokeMethod('addLog', params);
  }

  static error(dynamic content) {
    debugPrint(content);
    if (!_initSuccess) return;
    var params = Map<String, dynamic>();
    params["time"] = DateUtil.formatDate(DateTime.now());
    params["level"] = "error";
    params["content"] = content;
    _channel.invokeMethod('addLog', params);
  }

  static request(dynamic content) {
    debugPrint(content);
    if (!_initSuccess) return;
    var params = Map<String, dynamic>();
    params["time"] = DateUtil.formatDate(DateTime.now());
    params["level"] = "request";
    params["content"] = content;
    _channel.invokeMethod('addLog', params);
  }
}
