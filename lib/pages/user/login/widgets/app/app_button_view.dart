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
          () => Visibility(
            visible: s.btnEnabled.isTrue,
            replacement: AppDisabledButton(text: '登录'),
            child: AppButton(
              text: '登录',
              loadingText: '正在登录',
              disabled: s.isNotClick,
              onTap: s.submit,
            ),
          ),
        ),
        AppGaps.h32,
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Get.toNamed('/register'),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '没有账户？',
                  style: AppThemes.of().medium14text1,
                ),
                TextSpan(
                  text: '去注册',
                  style: AppThemes.of().medium14primary,
                ),
              ],
            ),
          ),
        ),
        // Visibility(
        //   visible: kDebugMode,
        //   child: Spacer(),
        // ),
        // Visibility(
        //   visible: kDebugMode,
        //   child: Obx(
        //     () => AppButton(
        //       text: '游客登录',
        //       loadingText: '正在登录',
        //       margin: EdgeInsets.symmetric(vertical: 16.h),
        //       disabled: s.isNotClick,
        //       onTap: s.guestLogin,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
