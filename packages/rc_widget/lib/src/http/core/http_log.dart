/*
* @overview: 
* @Author: rcc 
* @Date: 2024-01-29 14:52:30 
*/

import 'dart:math';
import 'dart:convert';
import 'package:logger/logger.dart';

import 'http_types.dart';

enum LogLevel {
  info(
    emoji: '💡',
    color: AnsiColor.fg(12),
  ),
  error(
    emoji: '⛔',
    color: AnsiColor.fg(196),
  );

  const LogLevel({
    required this.emoji,
    required this.color,
  });

  final String emoji;
  final AnsiColor color;
}

class HttpLog {
  HttpLog();

  dynamic data;
  Uri uri = Uri();
  String method = 'GET';
  Map<String, dynamic>? params;
  Map<String, dynamic>? headers;

  dynamic error;
  StackTrace? stackTrace;

  static final _infoLogger = Logger(
    printer: HttpPrinter(),
  );

  static final _errorLogger = Logger(
    printer: HttpPrinter(
      level: LogLevel.error,
    ),
  );

  static void i(HttpLog httpLog) {
    _infoLogger.i(httpLog);
  }

  static void e(HttpLog httpLog) {
    _errorLogger.e(httpLog);
  }
}

class HttpPrinter extends LogPrinter {
  static const topLeftCorner = '┌';
  static const bottomLeftCorner = '└';
  static const middleCorner = '├';
  static const verticalLine = '│';
  static const doubleDivider = '─';
  static const singleDivider = '┄';

  HttpPrinter({
    this.lineLength = 120,
    this.level = LogLevel.info,
  }) {
    _formatBorder();
  }

  final LogLevel level;
  final int lineLength;

  late final String _topBorder;
  late final String _middleBorder;
  late final String _bottomBorder;

  String get emoji => level.emoji;
  AnsiColor get color => level.color;

  @override
  List<String> log(LogEvent event) {
    final List<String> logs = [];

    if (event.message is HttpLog) {
      final HttpLog httpLog = event.message;

      final label = _formatLabel(httpLog.uri, httpLog.method);
      final time = _formatTime();
      final headers = _formatHeaders(httpLog.headers);
      final params = _formatParams(httpLog.params);
      final data = _formatData(httpLog.data);
      final error = _formatError(httpLog.error);
      final stackTrace = _formatStackTrace(httpLog.stackTrace);

      logs
        ..add(_topBorder)
        ..addAll(label)
        ..addAll(time)
        ..addAll(headers)
        ..addAll(params)
        ..addAll(data)
        ..addAll(stackTrace)
        ..addAll(error)
        ..add(_bottomBorder);
    }

    return logs;
  }

  /// 创建边框
  void _formatBorder() {
    final topBuffer = StringBuffer(topLeftCorner);
    final middleBuffer = StringBuffer(middleCorner);
    final bottomBuffer = StringBuffer(bottomLeftCorner);

    for (int i = 0; i < lineLength - 1; i++) {
      topBuffer.write(doubleDivider);
      middleBuffer.write(singleDivider);
      bottomBuffer.write(doubleDivider);
    }

    _topBorder = color(topBuffer.toString());
    _middleBorder = color(middleBuffer.toString());
    _bottomBorder = color(bottomBuffer.toString());
  }

  List<String> _formatLabel(Uri uri, String method) {
    final List<String> buffers = [];

    buffers.add(color('$verticalLine 🏳️‍🌈 类型: $method'));
    buffers.add(color('$verticalLine 🏳️‍🌈 接口: ${uri.path}'));
    buffers.add(color('$verticalLine 🏳️‍🌈 路径: ${uri.origin}${uri.path}'));
    buffers.add(_middleBorder);

    return buffers;
  }

  List<String> _formatTime() {
    final List<String> buffers = [];
    final now = DateTime.now().toString().replaceAll(RegExp(r"\..*$"), '');

    buffers.add(color('$verticalLine 🕗 $now'));
    buffers.add(_middleBorder);

    return buffers;
  }

  List<String> _formatHeaders(StringMap? map) {
    if (map == null || map.isEmpty) return [];

    final List<String> buffers = [];
    final str = stringifyMessage(map);

    buffers.add(color('$verticalLine ⚜️ 请求头'));
    buffers.add(color(verticalLine));

    for (final line in str.split('\n')) {
      buffers.add(color('$verticalLine $emoji $line'));
    }

    buffers.add(_middleBorder);

    return buffers;
  }

  List<String> _formatParams(StringMap? map) {
    if (map == null || map.isEmpty) return [];

    final List<String> buffers = [];
    final str = stringifyMessage(map);

    buffers.add(color('$verticalLine ⚜️ 请求参数'));
    buffers.add(color(verticalLine));

    for (final line in str.split('\n')) {
      buffers.add(color('$verticalLine $emoji $line'));
    }

    buffers.add(_middleBorder);

    return buffers;
  }

  List<String> _formatData(dynamic map) {
    final List<String> buffers = [];
    final str = stringifyMessage(map);

    buffers.add(color('$verticalLine ⚜️ 请求结果'));
    buffers.add(color(verticalLine));
    for (final line in str.split('\n')) {
      if (line.trim().isNotEmpty) {
        buffers.add(color('$verticalLine $emoji $line'));
      }
    }

    return buffers;
  }

  List<String> _formatError(dynamic map) {
    if (map == null) return [];

    final List<String> buffers = [];
    final str = stringifyMessage(map);

    buffers.add(color('$verticalLine ⚜️ 错误信息'));
    buffers.add(color(verticalLine));
    for (final line in str.split('\n')) {
      if (line.trim().isNotEmpty) {
        buffers.add(color('$verticalLine $emoji $line'));
      }
    }

    return buffers;
  }

  List<String> _formatStackTrace(StackTrace? stackTrace) {
    if (stackTrace == null) return [];

    final List<String> buffers = [];
    final str = stringifyMessage(stackTrace);

    buffers.add(_middleBorder);
    buffers.add(color('$verticalLine ⚜️ 堆栈跟踪'));
    buffers.add(color(verticalLine));

    final arr = str.split('\n');

    for (int i = 0; i < min(arr.length, 2); i++) {
      final line = arr[i];
      if (line.trim().isNotEmpty) {
        buffers.add(color('$verticalLine #$i  ${line.replaceFirst(RegExp(r'#\d+\s+'), '')}'));
      }
    }

    buffers.add(_middleBorder);

    return buffers;
  }

  Object toEncodableFallback(dynamic object) {
    return object.toString();
  }

  String stringifyMessage(dynamic message) {
    final finalMessage = message is Function ? message() : message;

    if (finalMessage is Map || finalMessage is Iterable) {
      final encoder = JsonEncoder.withIndent('  ', toEncodableFallback);
      return encoder.convert(finalMessage);
    } else {
      try {
        final map = json.decode(finalMessage);

        final encoder = JsonEncoder.withIndent('  ', toEncodableFallback);
        return encoder.convert(map);
      } catch (_) {}
      final all = finalMessage.toString();

      final StringBuffer buffer = StringBuffer();
      for (int i = 0; i < all.length; i++) {
        if (i > 0 && i % lineLength == 0) {
          buffer.write('\n');
        }
        buffer.write(all[i]);
      }

      return buffer.toString();
    }
  }
}
