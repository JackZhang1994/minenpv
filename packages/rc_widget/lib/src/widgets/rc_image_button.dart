/*
* @overview: 组件-图片按钮
* @Author: rcc 
* @Date: 2022-07-26 23:22:50 
*/

import 'package:flutter/material.dart';

import 'rc_ink_well.dart';

class RcImageButton extends StatelessWidget {
  const RcImageButton({
    Key? key,
    required this.name,
    required this.dimension,
    this.onTap,
    this.width,
    this.height,
    this.margin,
    this.imageDimension,
  }) : super(key: key);

  final String name;
  final double? width;
  final double? height;
  final double dimension;
  final double? imageDimension;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    Widget child = RcInkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(dimension / 2),
      child: SizedBox.square(
        dimension: dimension,
        child: Center(
          child: Image.asset(
            name,
            fit: BoxFit.cover,
            width: width ?? imageDimension,
            height: height ?? imageDimension,
          ),
        ),
      ),
    );

    if (margin != null) {
      child = Padding(
        padding: margin!,
        child: child,
      );
    }

    return child;
  }
}
