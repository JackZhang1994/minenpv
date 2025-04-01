/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 14:54:23 
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';
import 'package:yunyou_desktop/pages/user/login/controllers/login_controller.dart';
import 'package:yunyou_desktop/pages/user/register/controllers/register_controller.dart';

import '/themes/index.dart';
import '/widgets/base/app_asset_image.dart';
import '/widgets/public/app_text_field.dart';
import 'app_count_down_controller.dart';

class AppFormCard extends StatelessWidget {
  AppFormCard({
    super.key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.typeCode,
    this.typePage,
    this.marginTop,
    this.inputFormatters,
    this.obscureText = false,
  });

  final String icon;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  int? typeCode;
  int? typePage;

  final double? marginTop;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 96.h,
      margin: EdgeInsets.only(
        top: marginTop ?? 32.h,
      ),
      padding: AppSpacings.h24,
      decoration: AppThemes.of().input,
      child: Row(
        children: [
          AppAssetImage.square(
            'assets/images/user/$icon.webp',
            dimension: 48.w,
          ),
          AppGaps.w8,
          Expanded(
            child: AppTextField(
              hintText: hintText,
              controller: controller,
              obscureText: obscureText,
              inputFormatters: inputFormatters,
            ),
          ),
          typeCode == 2 ? _buildverifyCode() : Container()
        ],
      ),
    );
  }

  Widget _buildverifyCode() {
    final s = AppUserController.to;
    final v = (typePage == 1)
        ? LoginController.to.phone
        : RegisterController.to.phone;

    final countdown = Get.put(EditVerificationCountDownController(),
        tag: UniqueKey().toString());
    return Obx(() {
      if (countdown.status == EditVerificationCountDownStatus.init) {
        return verifyButton(
          text: '获取验证码',
          onPressed: () {
            s.sendCode(v.text);
            countdown.start();
            print('countdown start');
          },
        );
      }
      if (countdown.status == EditVerificationCountDownStatus.running) {
        return verifyButton(
            text: '${countdown.currentSecond}s', onPressed: () {});
      }
      if (countdown.status == EditVerificationCountDownStatus.complete) {
        return verifyButton(
          text: '重新获取',
          onPressed: () {
            s.sendCode(v.text);
            countdown.start();
            print('countdown start');
          },
        );
      }
      return Container();
    });

    // return Container(
    //   decoration: BoxDecoration(
    //     gradient: const LinearGradient(
    //       colors: [Color(0xff88F7BF), Color(0xffE6E75C)], // 渐变色的颜色数组
    //     ),
    //     borderRadius: BorderRadius.circular(8.0), // 圆角
    //   ),
    //   child: TextButton(
    //       onPressed: () {
    //         s.sendCode(v.phone.text);
    //       },
    //       style: const ButtonStyle(
    //           foregroundColor: WidgetStatePropertyAll(Colors.black)),
    //       child: const Text('获取验证码')),
    // );
  }
}

class verifyButton extends StatelessWidget {
  const verifyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff88F7BF), Color(0xffE6E75C)], // 渐变色的颜色数组
        ),
        borderRadius: BorderRadius.circular(8.0), // 圆角
      ),
      child: TextButton(
        style: const ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.black)),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
