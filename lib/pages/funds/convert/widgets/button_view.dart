/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 21:30:37 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/widgets/public/app_button.dart';

import '../controllers/convert_controller.dart';

class ButtonView extends StatelessWidget {
  const ButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = ConvertController.to;

    return Obx(() {
      return AppButton(
        text: '兑换',
        margin: EdgeInsets.only(top: 48.h, bottom: 80.h),
        disabled: s.isNotClick,
        onTap: s.submit,
      );
    });
  }
}
