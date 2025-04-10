import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/public/app_top_bar.dart';

import 'controllers/modify_pwd_controller.dart';
import 'widgets/app/app_button_view.dart';
import 'widgets/app/app_form_view.dart';

class ModifyPwdPage extends StatelessWidget {
  const ModifyPwdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: '修改密码', isMobile: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppFormView(),
            AppGaps.h42,
            AppButtonView(),
          ],
        ),
      ),
    );
  }
}

class ModifyPwdPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ModifyPwdController>(ModifyPwdController());
  }
}
