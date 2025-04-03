/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-10 16:07:08 
*/

import 'dart:io' show Platform;

import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  const AppUtils._();

  /// 查询字符串格式化
  static String fromQuery(String url, Map<String, dynamic> params) {
    String str = '$url?';

    for (final item in params.entries) {
      str += '${item.key}=${item.value}&';
    }

    return str.substring(0, str.length - 1);
  }

  /// 浏览器打开链接
  static Future<bool> openUrl(String value) async {
    try {
      final Uri url = Uri.parse(value);
      return await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  static bool isMobile() {
    return Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;
  }
}
