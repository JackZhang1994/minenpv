/*
* @overview: 我的-个人信息
* @Author: rcc 
* @Date: 2024-06-08 22:25:07 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';
import '/widgets/public/app_top_bar.dart';
import '/widgets/public/app_scaffold.dart';

import 'widgets/card_view.dart';
import 'widgets/loginout_view.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const AppTopBar(
        title: '个人信息',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 100.w),
        child: Container(
          margin: AppSpacings.h48,
          child: const Column(
            children: [
              TopCard(),
              CenterCard(),
              BottomCard(),
              LoginoutView(),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalPageBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put<>(());
  }
}
