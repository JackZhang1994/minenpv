/*
* @overview: 工具-屏幕适配
* @Author: rcc 
* @Date: 2022-11-28 11:14:43 
*/

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class RcScreenAdapt {
  RcScreenAdapt._();

  /// 是否初始化
  static bool _isInit = false;

  /// 设计图宽度及高度
  static const double _desktopAppUiWidth = 1800, _desktopAppUiHeight = 1200;
  static const double _mobileAppUiWidth = 375, _mobileAppUiHeight = 812;

  static double get _uiWidth =>
      (Platform.isAndroid || Platform.isIOS || Platform.isFuchsia) ? _mobileAppUiWidth : _desktopAppUiWidth;

  static double get _uiHeight =>
      (Platform.isAndroid || Platform.isIOS || Platform.isFuchsia) ? _mobileAppUiHeight : _desktopAppUiHeight;

  /// 屏幕宽度
  static double screenWidth = 0;

  /// 屏幕高度
  static double screenHeight = 0;

  /// 状态栏高度
  static double statusBarHeight = 0;

  /// 导航栏高度
  static double navigationBarHeight = 0;

  /// 宽度缩放比例
  static double get _scaleWidth => screenWidth / _uiWidth;

  /// 高度缩放比例
  static double get _scaleHeight => screenHeight / _uiHeight;

  /// 缩放比例
  static double get _zoomScale {
    double uiScale = _uiWidth / _uiHeight;
    final screenScale = screenWidth / screenHeight;

    final a = screenScale / uiScale;
    final b = uiScale / screenScale;
    final c = screenScale < uiScale ? min(a, b) : max(a, b);

    return c;
  }

  /// 屏幕适配初始化
  static void init(BuildContext context) {
    _isInit = true;

    if (screenWidth != 0 && statusBarHeight != 0) return;

    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
    statusBarHeight = MediaQuery.paddingOf(context).top;
    navigationBarHeight = MediaQuery.paddingOf(context).bottom;
  }

  /// 获取适配宽度
  static double getAdaptWidth(double width) {
    assert(_isInit, 'RcScreenAdapt未初始化');
    return width * _scaleWidth;
  }

  /// 获取适配高度
  static double getAdaptHeight(double height) {
    assert(_isInit, 'RcScreenAdapt未初始化');
    return height * _scaleHeight * _zoomScale;
  }

  /// 获取适配字体大小
  static double getAdaptFontSize(double fontSize) {
    assert(_isInit, 'RcScreenAdapt未初始化');
    return fontSize * _scaleHeight * _zoomScale;
  }

  /// 获取适配圆角
  static double getAdaptRadius(double radius) {
    assert(_isInit, 'RcScreenAdapt未初始化');
    return radius * min(_scaleWidth, _scaleHeight);
  }
}

extension RcScreenAdaptExtension on num {
  /// 获取适配宽度
  double get w => RcScreenAdapt.getAdaptWidth(toDouble()).toDouble();

  /// 获取适配高度
  double get h => RcScreenAdapt.getAdaptHeight(toDouble()).toDouble();

  /// 获取适配圆角
  double get r => RcScreenAdapt.getAdaptRadius(toDouble()).toDouble();

  /// 获取适配字体
  double get sp => RcScreenAdapt.getAdaptFontSize(toDouble()).toDouble();

  double get sw => this * RcScreenAdapt.screenWidth;

  double get sh => this * RcScreenAdapt.screenHeight;
}
