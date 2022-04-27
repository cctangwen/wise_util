import 'package:wise_util/util/language/languages.dart';

class LanguageUtil {
  static String _emptyString = "";

  static String getLanguageLabel(String lang) {
    Map<String, dynamic>? country = languages[lang];
    if (null == country) return _emptyString;
    Map<String, dynamic>? localesLabel = country['localesLabel'];
    if (null == localesLabel) return country['label'];
    if (null != localesLabel[lang]) return localesLabel[lang];
    return country['label'];
  }

  static String getRegionLabel(String lang, String locale) {
    Map<String, dynamic>? country = languages[lang];
    if (null == country) return _emptyString;
    Map<String, dynamic>? regionsLabel = country['regionsLabel'];
    if (null == regionsLabel) return country['label'];
    if (null != regionsLabel[locale]) return regionsLabel[locale];
    return country['label'];
  }

  static String getFlagIcon(String lang) {
    Map<String, dynamic>? country = languages[lang];
    if (null == country) return _emptyString;
    return country['icon'];
  }
}
