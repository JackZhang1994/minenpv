/*
* @overview: 工具-简单计算
* @Author: rcc 
* @Date: 2023-01-13 13:25:28 
*/

import 'package:decimal/decimal.dart';

class RcCalc {
  RcCalc._();

  /// 加法
  static String plus(String a, String b) {
    final result = Decimal.parse(a) + Decimal.parse(b);

    return result.toString();
  }

  /// 加法(数组)
  static String plusList(List<String> arr) {
    if (arr.isEmpty) return '';

    return arr.reduce((a, b) => (Decimal.parse(a) + Decimal.parse(b)).toString());
  }

  /// 减法
  static String minus(String a, String b) {
    final result = Decimal.parse(a) - Decimal.parse(b);

    return result.toString();
  }

  /// 减法(数组)
  static String minusList(List<String> arr) {
    if (arr.isEmpty) return '';

    return arr.reduce((a, b) => (Decimal.parse(a) - Decimal.parse(b)).toString());
  }

  /// 乘法
  static String times(String a, String b) {
    final result = Decimal.parse(a) * Decimal.parse(b);

    return result.toString();
  }

  /// 乘法(数组)
  static String timesList(List<String> arr) {
    if (arr.isEmpty) return '';

    return arr.reduce((a, b) => (Decimal.parse(a) * Decimal.parse(b)).toString());
  }

  /// 除法
  static String divide(String a, String b) {
    final result = (Decimal.parse(a) / Decimal.parse(b)).toDecimal();

    return result.toString();
  }

  /// 除法(数组)
  static String divideList(List<String> arr) {
    if (arr.isEmpty) return '';

    return arr.reduce((a, b) => (Decimal.parse(a) / Decimal.parse(b)).toDecimal().toString());
  }

  /// 科学计数转数字字符串
  static String toNumStr(String a) {
    return plus(a, '0');
  }
}
