/*
* @overview: 邀请页
* @Author: rcc 
* @Date: 2024-06-09 10:44:45 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/widgets/public/app_top_bar.dart';
import '/widgets/public/app_scaffold.dart';

import 'widgets/tips_view.dart';
import 'widgets/count_view.dart';
import 'widgets/button_view.dart';
import 'controllers/invite_controller.dart';

class InvitePage extends StatelessWidget {
  const InvitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const AppTopBar(
        title: '分享有礼',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 180.w),
        child: const Column(
          children: [
            TipsView(),
            ButtonView(),
            CountView(),
          ],
        ),
      ),
    );
  }
}

class InvitePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InviteController>(InviteController());
  }
}
