/*
* @overview: App-参数配置
* @Author: rcc 
* @Date: 2024-06-06 23:20:47 
*/

import 'package:flutter/material.dart';

class AppConfigs {
  AppConfigs._();

  /* -------- 环境配置  -------- */

  /// 环境变量
  static const Env env = Env.develop;

  /* -------- 应用配置  -------- */

  static const String appDisplayName = '光帆';

  /// App版本号
  static const String appVersion = '1.0.0';

  /// App名称
  static const String appName = 'xjh-vpn-desktop';

  /// App应用名
  static const String applicationName = 'xjh-vpn-desktop';

  /* -------- 请求配置  -------- */

  /// API请求地址
  static final String apiUrl = env.apiUrl;

  /* -------- 语言配置  -------- */

  /// App默认语言
  static const Locale defaultLocale = Locale('zh', 'CN');

  /// App语言列表
  static const List<Locale> supportedLocales = [
    Locale('zh', 'CN'),
  ];

  /* -------- 公共配置  -------- */

  /// 倒计时
  static const int count = 60;

  /// 异常上报-开关
  static final bool isReport = env.isReport;

  /// 异常上报-标识码
  static const String dsn = '';

  static String buildImageUrl(String path) {
    return apiUrl + path;
  }
}

enum Env {
  /// 开发环境
  develop(
    isReport: false,
    apiUrl: 'http://43.156.4.45:8011',
  ),

  /// 生产环境
  produce(
    isReport: true,
    apiUrl: 'http://43.156.4.45:8011',
  );

  /// api请求地址
  final String apiUrl;

  /// 异常上报开关
  final bool isReport;

  const Env({
    required this.apiUrl,
    required this.isReport,
  });
}
