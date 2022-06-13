import 'package:flutter/services.dart';
import 'package:wise_util/business/log/wise_log_service.dart';

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
          credentials['securityToken']);
    }
  }

  static config(String endpoint, String project, String logstore,
      String accessKeyID, String accessKeySecret, String securityToken) async {
    await _channel.invokeMethod('config', [
      endpoint,
      project,
      logstore,
      accessKeyID,
      accessKeySecret,
      securityToken
    ]);
  }

  static create() async {
    await _channel.invokeMethod('create');
  }

  static setTopic(String topic) async {
    await _channel.invokeMethod('setTopic', topic);
  }

  static addTag(Map<String, String> content) async {
    await _channel.invokeMethod('addTag', content);
  }

  static addLog(String name, [Map<String, String>? content]) async {
    if (content == null) content = {};
    content["name"] = name;
    content["gmt_create"] = "${DateTime.now().millisecondsSinceEpoch ~/ 1000}";
    return await _channel.invokeMethod('addLog', content);
  }
}
