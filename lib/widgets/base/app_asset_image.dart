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
    this.fit,
  });

  const AppAssetImage.square(
    this.name, {
    super.key,
    this.padding,
    double? dimension,
    this.fit,
  })  : width = dimension,
        height = dimension;

  final String name;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    Widget widget = Image.asset(
      name,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
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
