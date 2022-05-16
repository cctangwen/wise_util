import 'package:timezone/browser.dart';
import 'package:timezone/timezone.dart';

class DateUtil {
  static String ymmmdjms = 'yyyy-MM-dd HH:mm:ss';
  static String ymmmdjm = 'yyyy-MM-dd HH:mm';
  static String ymmmd = 'yyyy-MM-dd';
  static String jms = 'HH:mm:ss';
  static String jm = 'HH:mm';

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

  ///获取一天的开始字符串
  static String getTheBeginStringOfOneDay(dynamic value) {
    DateTime time = DateTime.now();
    if (value is String) {
      time = DateTime.parse(value);
    } else if (value is DateTime) {
      time = value;
    }
    return '${formatDate(time, format: DateUtil.ymmmd)} 00:00:00';
  }

  ///获取一天的开始字符串
  static DateTime getTheBeginTimeOfOneDay(dynamic value) {
    String formattedString = getTheBeginStringOfOneDay(value);
    return DateTime.parse(formattedString);
  }

  ///获取一天的结束
  static String getTheEndStringOfOneDay(dynamic value) {
    DateTime time = DateTime.now();
    if (value is String) {
      time = DateTime.parse(value);
    } else if (value is DateTime) {
      time = value;
    }
    return '${formatDate(time, format: DateUtil.ymmmd)} 23:59:59';
  }

  ///获取一天的结束
  static DateTime getTheEndTimeOfOneDay(dynamic value) {
    String formattedString = getTheEndStringOfOneDay(value);
    return DateTime.parse(formattedString);
  }

  ///utc0字符串
  static DateTime getUtc0({int? duration}) {
    DateTime time = DateTime.now();
    if (null != duration) {
      time = time.add(Duration(days: duration));
    }
    return localeTimeToUtc0Time(time);
  }

  ///UTC0时间转换城本地时间
  static DateTime utc0TimeToLocaleTime(dynamic value) {
    DateTime time = DateTime.now();
    if (value is String) {
      time = DateTime.parse(value);
    } else if (value is DateTime) {
      time = value;
    }
    return time.add(time.timeZoneOffset);
  }

  ///UTC0时间转换城本地时间字符串
  static String utc0TimeToLocaleString(dynamic value, {String? format}) {
    DateTime utc0Time = utc0TimeToLocaleTime(value);
    return formatDate(utc0Time, format: format);
  }

  ///本地时间转换成UTC0时间
  static DateTime localeTimeToUtc0Time(dynamic value) {
    DateTime time = DateTime.now();
    if (value is String) {
      time = DateTime.parse(value);
    } else if (value is DateTime) {
      time = value;
    }
    return TZDateTime.from(time, UTC);
  }

  ///本地时间转换成UTC0时间字符串
  static String localeTimeToUtc0String(dynamic value, {String? format}) {
    DateTime utc0Time = localeTimeToUtc0Time(value);
    return formatDate(utc0Time, format: format);
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
