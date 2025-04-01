/*
* @overview: 组件-手势检测
* @Author: rcc 
* @Date: 2022-12-01 11:29:20 
*/

import 'package:flutter/material.dart';

class RcGestureDetector extends StatelessWidget {
  const RcGestureDetector({
    Key? key,
    this.onTap,
    this.child,
    this.onDoubleTap,
  }) : super(key: key);

  final Widget? child;
  final void Function()? onTap;
  final void Function()? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
