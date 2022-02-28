class HttpResponseData {
  ///业务错误码
  late String code;

  ///业务响应数据
  dynamic data;

  ///业务是否正常应答
  bool isSuccess = false;

  ///接口PSN
  String? psn;

  ///错误信息
  late String msg;

  HttpResponseData(
      {required this.code,
      required this.msg,
      this.data,
      this.psn,
      this.isSuccess = false});

  HttpResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'];
    msg = json['msg'];
    psn = json['psn'];
    if (json['code'] == "0") {
      isSuccess = true;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['data'] = this.data;
    data['msg'] = this.msg;
    data['psn'] = this.psn;
    return data;
  }
}
