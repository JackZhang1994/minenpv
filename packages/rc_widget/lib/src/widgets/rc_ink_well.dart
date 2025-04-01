/*
* @overview: 组件-水波纹按钮
* @Author: rcc 
* @Date: 2022-11-28 13:18:59 
*/

import 'package:flutter/material.dart';

class RcInkWell extends StatelessWidget {
  const RcInkWell({
    Key? key,
    this.onTap,
    this.child,
    this.splashColor,
    this.borderRadius,
    this.highlightColor,
  }) : super(key: key);

  final Widget? child;
  final Color? splashColor;
  final Color? highlightColor;
  final void Function()? onTap;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        borderRadius: borderRadius,
        highlightColor: highlightColor,
        child: child,
      ),
    );
  }
}
