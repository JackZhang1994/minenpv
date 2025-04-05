import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yunyou_desktop/pages/user/login/controllers/login_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/public/app_button.dart';

class AppButtonView extends StatelessWidget {
  const AppButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = LoginController.to;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => AppButton(
            text: '注册',
            loadingText: '正在注册',
            disabled: s.isNotClick,
            onTap: s.submit,
          ),
        ),
        AppGaps.h32,
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Get.back(),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '已有账户？',
                  style: AppThemes.of().medium14text1,
                ),
                TextSpan(
                  text: '去登录',
                  style: AppThemes.of().medium14primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
