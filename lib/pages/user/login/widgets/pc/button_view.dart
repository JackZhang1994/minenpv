/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 21:30:37 
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';
import '/widgets/public/app_button.dart';
import '../../controllers/login_controller.dart';

class ButtonView extends StatelessWidget {
  const ButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = LoginController.to;

    return Column(
      children: [
        Obx(() {
          return AppButton(
            text: '登录',
            margin: EdgeInsets.only(top: 68.h, bottom: 48.h),
            disabled: s.isNotClick,
            onTap: s.submit,
          );
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return RcTextButton(
                text: s.isShowPassword.value ? '验证码登陆' : '密码登陆',
                padding: AppSpacings.h16v8,
                style: AppThemes.of().w400Text128,
                borderRadius: BorderRadius.circular(4.sp),
                onTap: () => s.isShowPassword.value = !s.isShowPassword.value,
              );
            }),
          ],
        ),
        Obx(() {
          return AppButton(
            text: '游客登录',
            margin: EdgeInsets.only(top: 48.h, bottom: 48.h),
            disabled: s.isNotClick,
            onTap: s.guestLogin,
            border: true,
          );
        }),
      ],
    );
  }
}
