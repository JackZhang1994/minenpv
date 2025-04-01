/*
* @overview: 工具-日志打印
* @Author: rcc 
* @Date: 2022-12-03 15:19:28 
*/

import 'package:logger/logger.dart';

class RcLog {
  RcLog._();

  static final Logger _logger = Logger();

  static void i(
    dynamic message, [
    String? tag,
    StackTrace? t,
  ]) {
    _logger.i(message, error: tag, stackTrace: t);
  }

  static void e(
    String tag, [
    dynamic e,
    StackTrace? t,
  ]) {
    _logger.e(tag, error: e, stackTrace: t);
  }
}
