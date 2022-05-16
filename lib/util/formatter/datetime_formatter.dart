import 'package:intl/intl.dart';

import '/config/wise_config.dart';

class DatetimeFormatter {
  ///格式化 YEAR_ABBR_MONTH
  static String formatDateYMMM(DateTime datetime) {
    String locale = WiseConfig.getRegion();
    var dateFormat = DateFormat.yMMM(locale);
    return dateFormat.format(datetime);
  }

  ///格式化 YEAR_ABBR_MONTH_DAY
  static String formatDateYMMMD(DateTime datetime) {
    String locale = WiseConfig.getRegion();
    var dateFormat = DateFormat.yMMMd(locale);
    return dateFormat.format(datetime);
  }

  ///格式化 YEAR_ABBR_MONTH_DAY_HOUR_MINUTE
  static String formatYMMMDJM(DateTime datetime) {
    String locale = WiseConfig.getRegion();
    var dateFormat = DateFormat.yMMMd(locale);
    dateFormat.add_jm();
    return dateFormat.format(datetime);
  }

  ///格式化 YEAR_ABBR_MONTH_DAY_HOUR_MINUTE_SECOND
  static String formatYMMMDJMS(DateTime datetime) {
    String locale = WiseConfig.getRegion();
    var dateFormat = DateFormat.yMMMd(locale);
    dateFormat.add_jms();
    return dateFormat.format(datetime);
  }

  ///格式化 YEAR_ABBR_MONTH_DAY_HOUR24_MINUTE
  static String formatYMMMDHM(DateTime datetime) {
    String locale = WiseConfig.getRegion();
    var dateFormat = DateFormat.yMMMd(locale);
    dateFormat.add_Hm();
    return dateFormat.format(datetime);
  }

  ///格式化 YEAR_ABBR_MONTH_DAY  HOUR24_MINUTE_SECOND
  static String formatYMMMDHMS(DateTime datetime) {
    String locale = WiseConfig.getRegion();
    var dateFormat = DateFormat.yMMMd(locale);
    dateFormat.add_Hms();
    return dateFormat.format(datetime);
  }

  ///格式化 HOUR_MINUTE
  static String formatJM(DateTime datetime) {
    String locale = WiseConfig.getRegion();
    var dateFormat = DateFormat.jm(locale);
    return dateFormat.format(datetime);
  }

  ///格式化 HOUR_MINUTE_SECOND
  static String formatJMS(DateTime datetime) {
    String locale = WiseConfig.getRegion();
    var dateFormat = DateFormat.jms(locale);
    return dateFormat.format(datetime);
  }

  ///格式化 HOUR24_MINUTE
  static String formatHM(DateTime datetime) {
    String locale = WiseConfig.getRegion();
    var dateFormat = DateFormat.Hm(locale);
    return dateFormat.format(datetime);
  }

  ///格式化 HOUR24_MINUTE_SECOND
  static String formatHMS(DateTime datetime) {
    String locale = WiseConfig.getRegion();
    var dateFormat = DateFormat.Hms(locale);
    return dateFormat.format(datetime);
  }
}
