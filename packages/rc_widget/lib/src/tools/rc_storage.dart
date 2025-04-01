/*
* @overview: 工具-本地存储
* @Author: rcc 
* @Date: 2022-12-05 14:02:34 
*/

import 'package:shared_preferences/shared_preferences.dart';

class RcStorage {
  RcStorage._();

  static SharedPreferences? _instance;

  static Future<SharedPreferences> getInstance() async {
    return _instance ??= await SharedPreferences.getInstance();
  }

  /// 存储字符串
  static Future<bool> setString(String key, String value) async {
    final prefs = await getInstance();
    final status = await prefs.setString(key, value);

    return status;
  }

  /// 获取字符串
  static Future<String> getString(String key, [String defaultValue = '']) async {
    final prefs = await getInstance();
    final value = prefs.getString(key);

    return value ?? defaultValue;
  }

  /// 存储字符串列表
  static Future<bool> setStringList(String key, List<String> value) async {
    final prefs = await getInstance();
    final status = await prefs.setStringList(key, value);

    return status;
  }

  /// 获取字符串列表
  static Future<List<String>> getStringList(String key) async {
    final prefs = await getInstance();
    final value = prefs.getStringList(key);

    return value ?? [];
  }

  /// 存储数字
  static Future<bool> setInt(String key, int value) async {
    final prefs = await getInstance();
    final status = await prefs.setInt(key, value);

    return status;
  }

  /// 获取数字
  static Future<int?> getInt(String key, [int? defaultValue]) async {
    final prefs = await getInstance();
    final value = prefs.getInt(key);

    return value ?? defaultValue;
  }

  /// 存储小数
  static Future<bool> setDouble(String key, double value) async {
    final prefs = await getInstance();
    final status = await prefs.setDouble(key, value);

    return status;
  }

  /// 获取小数
  static Future<double?> getDouble(String key, [double? defaultValue]) async {
    final prefs = await getInstance();
    final value = prefs.getDouble(key);

    return value ?? defaultValue;
  }

  /// 清除本地存储
  static Future<bool> remove(String key) async {
    final prefs = await getInstance();
    final status = await prefs.remove(key);

    return status;
  }

  /// 清除所有本地存储
  static Future<bool> clear() async {
    final prefs = await getInstance();
    final status = await prefs.clear();

    return status;
  }
}

class RcStorageKey {
  RcStorageKey._();

  /// superId
  static const String superId = 'rc_super_id';

  static const String token = 'rc_token';

  /// 主题标识
  static const String theme = 'rc_theme';

  /// 语言标识
  static const String language = 'rc_language';
}
