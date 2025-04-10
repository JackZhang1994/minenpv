import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/user/sign_out/controllers/sign_out_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/public/app_text_field.dart';

class AppFormView extends GetView<SignOutController> {
  const AppFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '注销后您的账户数据将被永久清空，此账户将无法重新登录，请谨慎操作。',
            style: AppThemes.of().regular18text1,
          ),
          AppGaps.h24,
          Text(
            '8-20位字符（字母或数字）',
            style: AppThemes.of().regular12primary,
          ),
          AppGaps.h16,
          AppTextField(
            hintText: '请输入密码',
            controller: controller.passwordController,
            obscureText: true,
            inputFormatters: RcInputFormatters.alphanumeric,
            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }
}
