/*
* @overview: 
* @Author: rcc 
* @Date: 2023-01-13 15:00:40 
*/

import 'dart:math';
import 'dart:async';
import 'package:flutter/services.dart';

class RcTools {
  RcTools._();

  /// 复制到剪切板
  static Future<bool> copyText(String text) {
    final Completer<bool> completer = Completer();

    Clipboard.setData(ClipboardData(text: text)).then((value) {
      completer.complete(true);
    }).catchError((_) {
      completer.completeError(false);
    });

    return completer.future;
  }

  /// 结尾去零
  static String removeZero(String text) {
    String newText = text;

    if (newText.contains('.')) {
      newText = newText.replaceAll(RegExp(r'0+$'), '');
      newText = newText.replaceAll(RegExp(r'\.$'), '');
    }

    return newText;
  }

  /// 格式化时间戳为指定格式的字符串。
  ///
  /// [timestamp] 是要格式化的时间戳。
  /// [format] 是时间格式字符串，默认为 'YYYY-MM-DD hh:mm:ss'。
  /// 返回格式化后的时间字符串。
  ///
  /// 示例：
  /// ```dart
  /// // 格式化为默认格式
  /// String result = dateFormat(1619369165000); // 返回 '2021-04-25 10:32:45'
  ///
  /// // 自定义格式
  /// String customFormat = 'YYYY年MM月DD日 HH时mm分ss秒';
  /// String result = dateFormat(1619369165000, customFormat); // 返回 '2021年04月25日 10时32分45秒'
  /// ```
  static String dateFormat(int timestamp, [String format = 'YYYY-MM-DD hh:mm:ss']) {
    final int fullTimestamp = int.parse(timestamp.toString().padRight(13, '0'));
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(fullTimestamp);

    final formatMap = {
      'YYYY': dateTime.year.toString(),
      'YY': dateTime.year.toString().substring(2),
      'MM': '${dateTime.month}'.padLeft(2, '0'),
      'M': '${dateTime.month}',
      'DD': '${dateTime.day}'.padLeft(2, '0'),
      'D': '${dateTime.day}',
      'HH': '${dateTime.hour}'.padLeft(2, '0'),
      'H': '${dateTime.hour}',
      'hh': '${dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour}'.padLeft(2, '0'),
      'h': '${dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour}',
      'mm': '${dateTime.minute}'.padLeft(2, '0'),
      'm': '${dateTime.minute}',
      'ss': '${dateTime.second}'.padLeft(2, '0'),
      's': '${dateTime.second}',
      'S': '${dateTime.millisecond}',
      'A': dateTime.hour >= 12 ? 'PM' : 'AM',
      'a': dateTime.hour >= 12 ? 'pm' : 'am',
    };

    String result = format.trim();

    formatMap.forEach((key, value) {
      result = result.replaceAll(key, value);
    });

    return result;
  }

  /// Duration格式化
  static String durationFormat(Duration duration) {
    final String hours = duration.inHours.toString().padLeft(1, '0');
    final String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (hours == '0') {
      return "$minutes:$seconds";
    } else {
      return "$hours:$minutes:$seconds";
    }
  }

  /// 随机id
  static String randomId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomInt = Random().nextInt(500);
    final randomDouble = Random().nextDouble();

    return '$timestamp$randomInt$randomDouble';
  }

  /// 截取小数位数
  ///
  /// [value] 小数字符
  /// [width] 小数位数
  /// [isZero] 是否去掉末尾零
  static String intercept(
    String text, {
    int width = 2,
    bool isZero = true,
  }) {
    final List<String> strs = text.split('.');
    final String integer = strs.first;
    final String decimal = strs.last;

    String result = text;

    if (strs.length == 2 && decimal.length > width) {
      result = '$integer.${decimal.substring(0, width)}';
    }

    if (isZero) {
      result = removeZero(result);
    }

    return result;
  }

  /// 获取时间戳
  /// [dateTime] 默认为当前时间
  /// [isFull] true 13位 or false 10位
  static int getTimestamp({
    DateTime? dateTime,
    bool isFull = true,
  }) {
    final DateTime t = dateTime ?? DateTime.now();
    final int timestamp = t.millisecondsSinceEpoch;

    return isFull ? timestamp : timestamp ~/ 1000;
  }

  /// 获取某天最后一秒时间戳
  /// [dateTime] 默认为当天
  /// [isFull] true 13位 or false 10位
  static int getDayLastTimestamp({
    DateTime? dateTime,
    bool isFull = true,
  }) {
    final DateTime t = dateTime ?? DateTime.now();
    final int timestamp = DateTime(t.year, t.month, t.day, 23, 59, 59).millisecondsSinceEpoch;

    return isFull ? timestamp : timestamp ~/ 1000;
  }

  /// 文字插入零宽度空格
  static String zeroText(String text) {
    return text.replaceAll('', '\u200B');
  }

  /// 字符串脱敏
  static String replaceWithSymbol(
    String text, {
    int begin = 6,
    int end = 6,
    String symbol = '****',
  }) {
    final int length = begin + end;

    if (text.length <= length) return text;

    final String beginStr = text.substring(0, begin);
    final String endStr = text.substring(text.length - end);

    return '$beginStr$symbol$endStr';
  }

  /// 查询字符串格式化
  static String fromQuery(String url, Map<String, dynamic> params) {
    final buffer = StringBuffer('$url?');

    for (final item in params.entries) {
      buffer.write('${item.key}=${item.value}&');
    }

    final str = buffer.toString();
    return str.substring(0, str.length - 1);
  }
}
