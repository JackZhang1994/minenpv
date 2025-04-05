import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/user/login/controllers/login_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/public/app_text_field.dart';

class AppFormView extends StatelessWidget {
  const AppFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = LoginController.to;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextField(
          hintText: '请输入邮箱',
          controller: s.phone,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        AppGaps.h16,
        AppTextField(
          hintText: '请输入密码（8-20位字母或数字）',
          controller: s.password,
          obscureText: true,
          inputFormatters: RcInputFormatters.alphanumeric,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          keyboardType: TextInputType.visiblePassword,
        ),
      ],
    );
  }
}
