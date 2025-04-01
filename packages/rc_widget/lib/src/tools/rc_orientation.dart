/*
* @overview: 工具-屏幕方向
* @Author: rcc 
* @Date: 2023-02-17 17:06:49 
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RcOrientation {
  RcOrientation._();

  /// 是否为横屏
  static bool isLandscape(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.landscape;
  }

  /// 是否为竖屏
  static bool isPortrait(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.portrait;
  }

  /// 设置屏幕方向为竖屏
  static Future<void> setLandscape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// 设置屏幕方向为横屏
  static Future<void> setPortrait() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
