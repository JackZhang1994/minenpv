import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/public/app_text_field.dart';
import 'package:yunyou_desktop/widgets/public/app_top_bar.dart';

import '../../../widgets/public/app_button.dart';
import 'controllers/modify_pwd_controller.dart';

class ModifyPwdPage extends StatelessWidget {
  const ModifyPwdPage({super.key});

  @override
  Widget build(BuildContext context) {
    ModifyPwdController s = ModifyPwdController.to;
    return Scaffold(
      appBar: AppTopBar(title: '修改密码', isMobile: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
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
              controller: s.password,
              obscureText: true,
              inputFormatters: RcInputFormatters.alphanumeric,
              contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              keyboardType: TextInputType.visiblePassword,
            ),
            AppGaps.h42,
            Obx(
              () => AppButton(
                text: '确定',
                loadingText: '正在修改',
                disabled: s.isNotClick,
                onTap: s.submit,
              ),
            ),
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
