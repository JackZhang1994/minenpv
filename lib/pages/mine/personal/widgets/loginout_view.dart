/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 11:27:04 
*/

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '../../mine_home/controllers/mine_home_controller.dart';
import '/themes/index.dart';

class LoginoutView extends StatelessWidget {
  const LoginoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return RcGestureDetector(
      onTap: () {
        MineController.to.signOut();
        // Get.toNamed('/');
      },
      child: Container(
        alignment: Alignment.center,
        height: 100.h,
        width: double.infinity,
        margin: AppSpacings.t32,
        padding: AppSpacings.h32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.sp),
          color: Colors.red.withOpacity(0.90),
        ),
        child: Text(
          '退出登陆',
          style: AppThemes.of().w400Text132,
        ),
      ),
    );
  }
}
