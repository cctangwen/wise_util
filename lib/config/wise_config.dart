import 'dart:ui' as ui;

import '/util/sp_util.dart';

class WiseConfig {
  ///语言设置,例如:ja-JP
  static const String _configLanguage = "wise_config_language";

  ///地区偏好设置,例如:ja-JP
  ///影响数字格式化，金额格式化，日期格式化显示
  static const String _configRegion = "wise_config_region";

  ///币种偏好设置,例如:CNY
  ///影响金额格式化
  static const String _configCurrency = "wise_config_currency";

  ///x-auth-token
  ///影响网络请求x-auth-token
  static const String _configAuthToken = "wise_config_auth_token";

  ///获取地区偏好
  static String getRegion() {
    return SpUtil.getString(_configRegion, defValue: "en-US")!;
  }

  ///设置地区偏好
  static setRegion(String regionCode) async {
    await SpUtil.putString(_configRegion, regionCode);
  }

  ///获取当前语言
  static String getLanguage() {
    String? localLocale = SpUtil.getString(_configLanguage, defValue: null);
    if (localLocale != null) return localLocale;
    ui.Locale deviceLocale = ui.window.locale;
    String code = "${deviceLocale.languageCode}-${deviceLocale.countryCode}";
    if (code.contains("zh")) return "zh-CN";
    if (code.contains("fr")) return "fr-FR";
    if (code.contains("ja")) return "ja-JP";
    return "en-US";
  }

  ///设置应用语言
  static Future<void> setLanguage(String locale) async {
    await SpUtil.putString(_configLanguage, locale);
  }

  ///删除地区偏好
  static removeRegion() async {
    await SpUtil.remove(_configRegion);
  }

  ///获取币种
  static String getCurrency() {
    return SpUtil.getString(_configCurrency, defValue: "USD")!;
  }

  ///设置币种
  static setCurrency(String currencyCode) async {
    await SpUtil.putString(_configCurrency, currencyCode);
  }

  ///删除币种
  static removeCurrency() async {
    await SpUtil.remove(_configCurrency);
  }

  ///获取AuthToken
  static String? getAuthToken() {
    return SpUtil.getString(_configAuthToken, defValue: null);
  }

  ///设置AuthToken
  static setAuthToken(String token) async {
    await SpUtil.putString(_configAuthToken, token);
  }

  ///删除AuthToken
  static removeAuthToken() async {
    await SpUtil.remove(_configAuthToken);
  }

  ///删除所有偏好
  static removeAll() async {
    await SpUtil.remove(_configRegion);
    await SpUtil.remove(_configCurrency);
    await SpUtil.remove(_configAuthToken);
    await SpUtil.remove(_configLanguage);
  }
}
