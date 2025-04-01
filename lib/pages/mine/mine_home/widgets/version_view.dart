/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 13:24:00 
*/

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';

class VersionView extends StatelessWidget {
  const VersionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 50.h,
      margin: AppSpacings.b32,
      child: Text(
        '当前版本：1.0.0',
        style: AppThemes.of().w400Text124,
      ),
    );
  }
}
