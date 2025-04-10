import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/user/modify_pwd/controllers/modify_pwd_controller.dart';
import 'package:yunyou_desktop/widgets/public/app_button.dart';

class AppButtonView extends GetView<ModifyPwdController> {
  const AppButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Obx(
        () => Visibility(
          visible: controller.btnEnabled.isTrue,
          replacement: AppDisabledButton(text: '确定'),
          child: AppButton(
            text: '确定',
            loadingText: '正在提交',
            disabled: controller.isNotClick,
            onTap: controller.submit,
          ),
        ),
      ),
    );
  }
}
