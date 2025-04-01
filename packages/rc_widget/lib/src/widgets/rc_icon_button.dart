/*
* @overview: 组件-Icon按钮
* @Author: rcc 
* @Date: 2023-02-17 15:05:55 
*/

import 'package:flutter/material.dart';

import 'rc_ink_well.dart';

class RcIconButton extends StatelessWidget {
  const RcIconButton({
    Key? key,
    required this.icon,
    required this.dimension,
    this.onTap,
    this.color,
    this.margin,
    this.iconSize,
  }) : super(key: key);

  final Color? color;
  final IconData icon;
  final double? iconSize;
  final double dimension;

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
          child: Icon(
            icon,
            color: color,
            size: iconSize,
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
