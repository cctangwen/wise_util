import 'package:intl/intl.dart';

import '/config/wise_config.dart';

class CurrencyFormatter {
  ///格式化货币
  static String format(number, {bool showSymbol = true, String? currencyName}) {
    if (number == null) {
      number = 0;
    } else if (number is String) {
      try {
        number = number.isEmpty ? 0 : double.parse(number);
      } catch (e) {
        number = 0;
      }
    }
    var currencyFormat = showSymbol
        ? _getSimpleCurrency(currencyName: currencyName)
        : _getCurrency(currencyName: currencyName);
    return currencyFormat.format(number);
  }

  ///获取货币符号
  static String getSymbol() {
    return _getSimpleCurrency().currencySymbol;
  }

  ///获取小数分隔符
  static String getDecimalSeparator() {
    String temp = format(0, showSymbol: false);
    if (temp.contains(",")) {
      return ",";
    } else if (temp.contains(".")) {
      return ".";
    } else {
      return "";
    }
  }

  ///获取小数位数
  static int getDecimalPlaces() {
    return _getSimpleCurrency().decimalDigits ?? 2;
  }

  ///获取简单金额,例如:$1.00
  static NumberFormat _getSimpleCurrency({String? currencyName}) {
    String name = WiseConfig.getCurrency();
    String locale = WiseConfig.getRegion();
    if (null != currencyName) {
      name = currencyName;
    }
    return NumberFormat.simpleCurrency(name: name, locale: locale);
  }

  ///获取金额,例如:USD 1.00
  static NumberFormat _getCurrency({String? currencyName}) {
    String name = WiseConfig.getCurrency();
    String locale = WiseConfig.getRegion();
    if (null != currencyName) {
      name = currencyName;
    }
    return NumberFormat.currency(name: name, locale: locale);
  }
}
