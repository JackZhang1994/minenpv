/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 10:58:37 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';
import '/widgets/base/app_asset_image.dart';

import '../controllers/invite_controller.dart';

class TipsView extends StatelessWidget {
  const TipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppAssetImage.square(
          'assets/images/mine/giving.webp',
          dimension: 396.w,
          padding: AppSpacings.t48,
        ),
        Text(
          '推荐朋友 分享有礼',
          style: AppThemes.of().w500Text140,
        ),
        Padding(
          padding: EdgeInsets.only(top: 48.h, bottom: 64.h),
          child: Obx(() {
            final s = InviteController.to;
            final code = s.invite.value.code.code;
            final percentage =
                RcTools.removeZero(s.invite.value.codePayback.toString());

            return Text(
              '您分享的用户与您绑定成功后开通任意会员套餐, 您可自动获得40%的同等级会员时长,永久有效(可直接分享链接给被推荐人,或被推荐人在绑定手机/注册时在推荐人框输入您的用户 ID, 被推荐人可获得首日新用户专享 特价优惠)！',
              style: AppThemes.of().w400Text328,
            );
          }),
        ),
      ],
    );
  }
}
