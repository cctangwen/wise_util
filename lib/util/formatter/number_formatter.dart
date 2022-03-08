import 'package:intl/intl.dart';

import '/config/wise_config.dart';

///数字格式化类
class NumberFormatter {
  ///格式化数字
  ///number:格式化内容
  ///isPercent：是否是百分数，若为true，则格式化结果添加百分号（默认不是）。
  static String format(number, {bool isPercent = false}) {
    if (number == null) {
      number = 0;
    } else if (number is String) {
      try {
        number = number.isEmpty ? 0 : double.parse(number);
      } catch (e) {
        number = 0;
      }
    }
    String locale = WiseConfig.getRegion();
    var numberFormat = isPercent
        ? NumberFormat.decimalPercentPattern(locale: locale)
        : NumberFormat.decimalPattern(locale);
    return numberFormat.format(number);
  }
}
