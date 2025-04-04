/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 11:27:04 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';

class RenewalView extends StatelessWidget {
  const RenewalView({super.key});

  @override
  Widget build(BuildContext context) {
    return RcGestureDetector(
      onTap: () => Get.toNamed('/combo'),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.sp),
          color: Color(0xff147f4f),
        ),
        alignment: Alignment.center,
        margin: AppSpacings.h48,
        padding: AppSpacings.h16,
        child: Text(
          '续费会员',
          style: AppThemes.of().w400Text132,
        ),
      ),
    );
  }
}
