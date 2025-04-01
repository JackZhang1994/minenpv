/*
* @overview: 组件-状态栏样式
* @Author: rcc 
* @Date: 2022-11-28 13:55:51 
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RcSystemStyle extends StatelessWidget {
  const RcSystemStyle({
    Key? key,
    required this.child,
    this.systemOverlayStyle,
    this.sized = true,
  }) : super(key: key);

  final bool sized;
  final Widget child;
  final SystemUiOverlayStyle? systemOverlayStyle;

  SystemUiOverlayStyle get value {
    const defaultStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
    );

    return systemOverlayStyle ?? defaultStyle;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: value,
      sized: sized,
      child: child,
    );
  }
}

class RcOverlayStyle {
  RcOverlayStyle._();

  static const light = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
  );

  static const dark = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  );
}
