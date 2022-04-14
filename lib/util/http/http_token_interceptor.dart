import 'package:dio/dio.dart';
import 'package:wise_util/config/wise_config.dart';

class HttpTokenInterceptor extends Interceptor {
  final String url;

  HttpTokenInterceptor(this.url) : super();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String reqUrl = response.requestOptions.uri.toString();
    if (url == reqUrl) {
      String? token = response.headers.value("x-auth-token");
      print("捕获到新的x-auth-token：$token");
      if (null != token) WiseConfig.setAuthToken(token);
    }
    handler.next(response);
  }
}
