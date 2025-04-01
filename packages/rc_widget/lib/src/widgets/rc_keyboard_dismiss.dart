/*
* @overview: 组件-点击空白关闭键盘
* @Author: rcc 
* @Date: 2022-11-28 11:32:19 
*/

import 'package:flutter/material.dart';

class RcKeyboardDismiss extends StatelessWidget {
  const RcKeyboardDismiss({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
