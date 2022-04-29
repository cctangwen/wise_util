import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:wise_util/util/http/http_token_interceptor.dart';

import '/config/wise_config.dart';
import '/res/wise_localizations.dart';
import '/widget/wise_loading.dart';
import '/widget/wise_snack_bar.dart';
import 'http_log_interceptor.dart';
import 'http_response_data.dart';

class HttpManager {
  ///连接超时时间
  static const int _httpConnectTimeout = 10000;

  ///发送超时时间
  static const int _httpSendTimeout = 30000;

  ///读取超时时间
  static const int _httpReceiveTimeout = 30000;

  ///默认content-type
  static const String _defaultContentType = "application/json";

  Dio? _dio;

  factory HttpManager() => _instance;

  static final HttpManager _instance = HttpManager._internal();

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal() {
    if (null == _dio) {
      _dio = Dio(BaseOptions(
        connectTimeout: _httpConnectTimeout,
        sendTimeout: _httpSendTimeout,
        receiveTimeout: _httpReceiveTimeout,
      ));

      ///debug模式下添加日志拦截器
      if (kDebugMode) {
        _dio!.interceptors.add(HttpLogInterceptor());
      }
    }
  }

  String? _loginPageAlisa;

  void setLoginPageAlisa(String loginPageAlisa) {
    _loginPageAlisa = loginPageAlisa;
  }

  void addTokenInterceptor(String url) {
    if (null != _dio) _dio!.interceptors.add(HttpTokenInterceptor(url));
  }

  ///GET请求
  Future<HttpResponseData> get(api,
      {params,
      bool withLoadingHint = true,
      bool withErrorHint = true,
      String? contentType}) async {
    return await _request(
        api: api,
        method: 'get',
        params: params,
        withLoadingHint: withLoadingHint,
        withErrorHint: withErrorHint,
        contentType: contentType);
  }

  ///POST请求
  Future<HttpResponseData> post(api,
      {params,
      bool withLoadingHint = true,
      bool withErrorHint = true,
      String? contentType}) async {
    return await _request(
        api: api,
        method: 'post',
        params: params,
        withLoadingHint: withLoadingHint,
        withErrorHint: withErrorHint,
        contentType: contentType);
  }

  Future<HttpResponseData> _request(
      {required String api,
      required String method,
      params,
      required bool withLoadingHint,
      required bool withErrorHint,
      String? contentType}) async {
    if (withLoadingHint) {
      WiseLoading.show();
    }
    _dio!.options.headers["content-type"] = contentType ?? _defaultContentType;
    _dio!.options.headers["accept-language"] =
        Get.locale?.toLanguageTag() ?? "en-US";
    if (null != WiseConfig.getAuthToken()) {
      _dio!.options.headers["x-auth-token"] = WiseConfig.getAuthToken();
    } else {
      _dio!.options.headers.remove("x-auth-token");
    }
    WiseString strings =
        WiseLocalizations.of(Get.context!)?.currentLocalization ??
            EnWiseString();
    HttpResponseData httpResponseData;
    try {
      Response dioResponse = await (method == 'get'
          ? _dio!.get(api, queryParameters: params)
          : _dio!.post(api, data: params));

      Map<String, dynamic> resp = dioResponse.data;
      httpResponseData = HttpResponseData.fromJson(resp);
      if (withLoadingHint) {
        WiseLoading.dismiss();
      }
      if (!httpResponseData.isSuccess && withErrorHint) {
        WiseSnackBar.showSnackBar(
            title: strings.error, msg: httpResponseData.msg);
        _checkLoginAuth(httpResponseData.code);
      }
    } catch (e) {
      httpResponseData =
          HttpResponseData(code: "-1", msg: strings.networkError);
      if (withLoadingHint) {
        WiseLoading.dismiss();
      }
      if (withErrorHint) {
        WiseSnackBar.showSnackBar(
            title: strings.error, msg: strings.networkError);
      }
    }
    return httpResponseData;
  }

  _checkLoginAuth(String errorCode) {
    if (errorCode == "SYS001") {
      String currentRoute = Get.currentRoute;
      print(
          "捕获到登录拦截代码：$errorCode,当前页面路由：$currentRoute，登录页面路由：$_loginPageAlisa");
      if (_loginPageAlisa != null && currentRoute != _loginPageAlisa)
        Get.offAllNamed(_loginPageAlisa!);
    }
  }
}
