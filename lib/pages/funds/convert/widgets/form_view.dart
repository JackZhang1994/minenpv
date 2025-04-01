/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 21:00:08 
*/

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';
import '/widgets/public/app_text_field.dart';

import '../controllers/convert_controller.dart';

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 96.h,
      margin: EdgeInsets.only(top: 64.h),
      padding: AppSpacings.h24,
      decoration: AppThemes.of().input,
      child: AppTextField(
        hintText: '请输入兑换码',
        controller: ConvertController.to.code,
      ),
    );
  }
}
