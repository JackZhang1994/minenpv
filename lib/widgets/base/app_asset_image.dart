/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 10:57:14 
*/

import 'package:flutter/material.dart';

class AppAssetImage extends StatelessWidget {
  const AppAssetImage(
    this.name, {
    super.key,
    this.width,
    this.height,
    this.padding,
  });

  const AppAssetImage.square(
    this.name, {
    super.key,
    this.padding,
    double? dimension,
  })  : width = dimension,
        height = dimension;

  final String name;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    Widget widget = Image.asset(
      name,
      width: width,
      height: height,
    );

    if (padding != null) {
      widget = Padding(
        padding: padding!,
        child: widget,
      );
    }

    return widget;
  }
}
