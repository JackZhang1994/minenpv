/*
* @overview: 用户-注册页
* @Author: rcc 
* @Date: 2024-06-08 20:56:34 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/themes/index.dart';
import '/widgets/public/app_top_bar.dart';
import '/widgets/public/app_scaffold.dart';

import 'widgets/form_view.dart';
import 'widgets/tips_view.dart';
import 'widgets/button_view.dart';
import 'controllers/register_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const AppTopBar(
        title: '注册账号',
      ),
      body: SingleChildScrollView(
        padding: AppSpacings.h48,
        child: const Column(
          children: [
            FormView(),
            ButtonView(),
            TipsView(),
          ],
        ),
      ),
    );
  }
}

class RegisterPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController());
  }
}
