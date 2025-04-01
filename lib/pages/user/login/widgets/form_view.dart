/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 21:00:08 
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';

import '../../../../themes/index.dart';
import '/widgets/public/app_form_card.dart';

import '../controllers/login_controller.dart';

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = LoginController.to;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RcTextButton(
              text: '没有帐号?马上注册',
              padding: AppSpacings.h16v8,
              style: AppThemes.of().w400Text128,
              borderRadius: BorderRadius.circular(4.sp),
              onTap: () => Get.toNamed('/register'),
            ),
          ],
        ),
        AppFormCard(
          icon: 'icon-1',
          hintText: '请输入邮箱',
          marginTop: 32.h,
          controller: s.phone,
        ),
        Obx(() {
          return AppFormCard(
            typeCode: s.isShowPassword.value ? 0 : 2,
            typePage: s.isShowPassword.value ? 0 : 1,
            icon: 'icon-2',
            hintText: s.isShowPassword.value ? '请输入密码（8-20位字母或数字）' : '请输入验证码',
            obscureText: s.isShowPassword.value ? true : false,
            controller: s.isShowPassword.value ? s.password : s.verifycode,
            inputFormatters: RcInputFormatters.alphanumeric,
          );
        })
      ],
    );
  }
}
