/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 11:02:26 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';
import '/widgets/base/app_asset_image.dart';

import '../controllers/invite_controller.dart';

class ButtonView extends StatelessWidget {
  const ButtonView({super.key});

  void showQrCode() {
    showDialog(
      context: Get.overlayContext!,
      builder: (_) {
        return Center(
          child: Container(
            width: 480.w,
            height: 480.h,
            padding: AppSpacings.all32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.sp),
            ),
            child: RcQrCode(
              size: double.infinity,
              data: InviteController.to.inviteUrl,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton(
          icon: 'share',
          text: '通过连接分享',
          onTap: () async {
            final isSuccess =
                await RcTools.copyText(InviteController.to.inviteUrl);

            RcToast(isSuccess ? '已复制到剪切板' : '复制失败');
          },
        ),
        SizedBox(
          width: 64.w,
        ),
        _buildButton(
          icon: 'code',
          text: '通过二维码分享',
          onTap: showQrCode,
        ),
      ],
    );
  }

  Widget _buildButton({
    required String icon,
    required String text,
    void Function()? onTap,
  }) {
    return Expanded(
      child: RcGestureDetector(
        onTap: onTap,
        child: Container(
          height: 108.h,
          margin: AppSpacings.t32,
          decoration: AppThemes.of().card4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppAssetImage.square(
                'assets/images/mine/$icon.webp',
                dimension: 40.w,
                padding: EdgeInsets.only(left: 28.w, right: 28.w),
              ),
              Text(
                text,
                style: AppThemes.of().w400Text228,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
