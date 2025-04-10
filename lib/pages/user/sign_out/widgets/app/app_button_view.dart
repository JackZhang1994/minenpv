import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/user/sign_out/controllers/sign_out_controller.dart';
import 'package:yunyou_desktop/widgets/public/app_button.dart';

class AppButtonView extends GetView<SignOutController> {
  const AppButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Obx(
        () => Visibility(
          visible: controller.btnEnabled.isTrue,
          replacement: AppDisabledButton(text: '注销'),
          child: AppButton(
            text: '注销',
            loadingText: '正在注销',
            disabled: controller.isNotClick,
            onTap: controller.signOut,
          ),
        ),
      ),
    );
  }
}
