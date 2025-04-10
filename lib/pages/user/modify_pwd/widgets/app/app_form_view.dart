import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/user/modify_pwd/controllers/modify_pwd_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/public/app_text_field.dart';

class AppFormView extends GetView<ModifyPwdController> {
  const AppFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '您可以随时修改账户密码，保障账户安全。修改密码没有次数上限。',
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
        )
      ],
    );
  }
}
