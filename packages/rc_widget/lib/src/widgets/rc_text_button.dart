/*
* @overview: 组件-文字按钮
* @Author: rcc 
* @Date: 2022-11-30 15:52:42 
*/

import 'package:flutter/material.dart';

import 'rc_ink_well.dart';

class RcTextButton extends StatelessWidget {
  const RcTextButton({
    Key? key,
    this.onTap,
    this.style,
    this.margin,
    this.borderRadius,
    this.text = '',
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final void Function()? onTap;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    Widget child = RcInkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: style,
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
