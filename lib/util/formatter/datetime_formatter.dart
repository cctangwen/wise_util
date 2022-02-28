import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';

import '/config/wise_config.dart';

class DatetimeFormatter {
  ///UTC0时间转换城本地时间
  static DateTime utc0TimeToLocaleTime(String time) {
    var offset = DateTime.parse(time).timeZoneOffset;
    var date = DateTime.parse(time).add(offset);
    return date;
  }

  ///本地时间转换成UTC0时间
  static DateTime localeTimeToUtc0Time(DateTime time) {
    return TZDateTime.from(time, UTC);
  }

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
