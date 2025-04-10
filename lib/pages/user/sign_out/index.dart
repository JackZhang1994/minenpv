import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/public/app_top_bar.dart';

import 'controllers/sign_out_controller.dart';
import 'widgets/app/app_account_view.dart';
import 'widgets/app/app_button_view.dart';
import 'widgets/app/app_form_view.dart';

class SignOutPage extends GetView<SignOutController> {
  const SignOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: '注销账户',
        isMobile: true,
      ),
      body: Column(
        children: [
          AppAccountView(),
          AppGaps.h8,
          AppFormView(),
          AppGaps.h42,
          AppButtonView(),
        ],
      ),
    );
  }
}

class SignOutPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SignOutController>(SignOutController());
  }
}
