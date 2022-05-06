import 'package:wise_util/util/formatter/datetime_formatter.dart';

class DateUtil {
  static String ymmmdjms = 'yyyy-MM-dd HH:mm:ss';
  static String ymmmdjm = 'yyyy-MM-dd HH:mm';
  static String ymmmd = 'yyyy-MM-dd';

  /// format date by DateTime.
  /// format 转换格式(已提供常用格式 DateFormats，可以自定义格式：'yyyy/MM/dd HH:mm:ss')
  /// 格式要求
  /// year -> yyyy/yy   month -> MM/M    day -> dd/d
  /// hour -> HH/H      minute -> mm/m   second -> ss/s
  static String formatDate(DateTime dateTime, {String? format}) {
    format = format ?? DateUtil.ymmmdjms;
    if (format.contains('yy')) {
      String year = dateTime.year.toString();
      if (format.contains('yyyy')) {
        format = format.replaceAll('yyyy', year);
      } else {
        format = format.replaceAll(
            'yy', year.substring(year.length - 2, year.length));
      }
    }
    format = _comFormat(dateTime.month, format, 'M', 'MM');
    format = _comFormat(dateTime.day, format, 'd', 'dd');
    format = _comFormat(dateTime.hour, format, 'H', 'HH');
    format = _comFormat(dateTime.minute, format, 'm', 'mm');
    format = _comFormat(dateTime.second, format, 's', 'ss');
    format = _comFormat(dateTime.millisecond, format, 'S', 'SSS');

    return format;
  }

  ///获取一天的开始
  static String getTheBeginOfOneDay(DateTime dateTime) {
    return '${formatDate(dateTime, format: DateUtil.ymmmd)} 00:00:00';
  }

  ///获取一天的结束
  static String getTheEndOfOneDay(DateTime dateTime) {
    return '${formatDate(dateTime, format: DateUtil.ymmmd)} 23:59:59';
  }

  ///获取当前Utc0的开始时间
  static String getTheBeginOfCurrentUtc0() {
    DateTime now = DatetimeFormatter.localeTimeToUtc0Time(DateTime.now());
    return getTheBeginOfOneDay(now);
  }

  ///获取当前Utc0的结束时间
  static String getTheEndOfCurrentUtc0() {
    DateTime now = DatetimeFormatter.localeTimeToUtc0Time(DateTime.now());
    return getTheEndOfOneDay(now);
  }

  static String _comFormat(
      int value, String format, String single, String full) {
    if (format.contains(single)) {
      if (format.contains(full)) {
        format =
            format.replaceAll(full, value < 10 ? '0$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
  }
}
