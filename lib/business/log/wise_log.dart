import 'package:flutter/services.dart';

///阿里云远程日志服务
class WiseLog {
  static const MethodChannel _channel = const MethodChannel('aliyun_log');

  static config(String endpoint, String project, String logstore,
      String accessKeyID, String accessKeySecret) async {
    await _channel.invokeMethod(
        'config', [endpoint, project, logstore, accessKeyID, accessKeySecret]);
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
