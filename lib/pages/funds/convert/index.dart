/*
* @overview: 资金-兑换页
* @Author: rcc 
* @Date: 2024-06-08 22:13:33 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/themes/index.dart';
import '/widgets/public/app_top_bar.dart';
import '/widgets/public/app_scaffold.dart';

import 'widgets/form_view.dart';
import 'widgets/tips_view.dart';
import 'widgets/button_view.dart';
import 'controllers/convert_controller.dart';

class ConvertPage extends StatelessWidget {
  const ConvertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const AppTopBar(
        title: '卡号兑换1',
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

class ConvertPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ConvertController>(ConvertController());
  }
}
