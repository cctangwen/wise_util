import 'package:intl/intl.dart';

import '/config/wise_config.dart';

class NumberFormatter {
  ///格式化数字
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
