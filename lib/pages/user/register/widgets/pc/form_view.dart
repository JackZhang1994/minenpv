/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 21:00:08 
*/

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/widgets/public/app_form_card.dart';
import '../../controllers/register_controller.dart';

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = RegisterController.to;
    return Column(
      children: [
        AppFormCard(
          icon: 'icon-1',
          hintText: '请输入邮箱',
          marginTop: 64.h,
          controller: s.phone,
        ),
        AppFormCard(
          icon: 'icon-1',
          hintText: '请输入验证码',
          controller: s.verifycode,
          typeCode: 2,
          typePage: 2,
        ),
        AppFormCard(
          icon: 'icon-2',
          hintText: '请输入密码（8-20位字母或数字）',
          obscureText: true,
          controller: s.password,
          inputFormatters: RcInputFormatters.alphanumeric,
        ),
      ],
    );
  }
}
