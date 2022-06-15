import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:wise_util/business/log/wise_log_service.dart';
import 'package:wise_util/util/date_util.dart';

///阿里云远程日志服务
class WiseLog {
  static const MethodChannel _channel = const MethodChannel('wise_util');

  static init(String appAlisa) async {
    var resp = await WiseLogService.getAccessToken(appAlisa);
    if (null != resp) {
      Map<String, dynamic> credentials = resp['logservice_credentials'];
      await config(
          credentials['endpoint'],
          credentials['project'],
          credentials['logstore'],
          credentials['accessKeyId'],
          credentials['accessKeySecret'],
          credentials['securityToken'],
          appAlisa);
    }
  }

  static config(
      String endpoint,
      String project,
      String logstore,
      String accessKeyID,
      String accessKeySecret,
      String securityToken,
      String appAlisa) async {
    await _channel.invokeMethod('init', [
      endpoint,
      project,
      logstore,
      accessKeyID,
      accessKeySecret,
      securityToken,
      appAlisa
    ]);
  }

  static addTag(Map<String, String> content) async {
    await _channel.invokeMethod('addTag', content);
  }

  static debug(dynamic content) async {
    var params = Map<String, dynamic>();
    params["time"] = DateUtil.formatDate(DateTime.now());
    params["level"] = "debug";
    params["content"] = content.toString();
    debugPrint(content);
    return await _channel.invokeMethod('addLog', params);
  }

  static info(dynamic content) async {
    var params = Map<String, dynamic>();
    params["time"] = DateUtil.formatDate(DateTime.now());
    params["level"] = "info";
    params["content"] = content;
    return await _channel.invokeMethod('addLog', params);
  }

  static error(dynamic content) async {
    var params = Map<String, dynamic>();
    params["time"] = DateUtil.formatDate(DateTime.now());
    params["level"] = "error";
    params["content"] = content;
    return await _channel.invokeMethod('addLog', params);
  }
}
