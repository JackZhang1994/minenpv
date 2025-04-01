/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 12:44:31 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import '/themes/index.dart';
import '/widgets/base/app_asset_image.dart';
import '/controllers/public/app_user_controller.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      margin: AppSpacings.h32,
      padding: AppSpacings.v32,
      // decoration: AppThemes.of().bottomBorder1,
      child: Column(
        children: [
          Row(
            children: [
              _buildAvatar(),
              _buildContent(),
            ],
          ),
          // _buildConvert(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return AppAssetImage.square(
      'assets/images/public/avatar.png',
      dimension: 112.w,
      padding: AppSpacings.r16,
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildName(),
          _buildId(),
        ],
      ),
    );
  }

  Widget _buildName() {
    final s = AppUserController.to;

    return RcGestureDetector(
      onTap: () {
        final path = s.isLogin ? '/personal' : '/login';

        Get.toNamed(path);
      },
      child: Row(
        children: [
          Flexible(
            child: Obx(() {
              return Text(
                s.isLogin ? '迅捷狐' : '登录',
                style: AppThemes.of().w500Text140,
              );
            }),
          ),
          AppGaps.w8,
          AppAssetImage.square(
            'assets/images/public/arrow-1.webp',
            dimension: 32.w,
          ),
        ],
      ),
    );
  }

  Widget _buildId() {
    final s = AppUserController.to;

    return Row(
      children: [
        Obx(() {
          return Text(
            'ID：${s.user.uid}',
            style: AppThemes.of().w400Text328,
          );
        }),
        AppGaps.w16,
        RcGestureDetector(
          onTap: () async {
            final result = await RcTools.copyText(s.user.uid.toString());

            RcToast(result ? '复制成功' : '复制失败');
          },
          child: Container(
            alignment: Alignment.center,
            width: 56.w,
            height: 32.h,
            decoration: AppThemes.of().button3,
            child: Text(
              '复制',
              style: AppThemes.of().w400Text320,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildConvert() {
  //   return RcGestureDetector(
  //     onTap: () => Get.toNamed('/convert'),
  //     child: Container(
  //       height: 68.h,
  //       decoration: AppThemes.of().button2,
  //       alignment: Alignment.center,
  //       margin: AppSpacings.t24,
  //       padding: AppSpacings.h16,
  //       child: Text(
  //         '卡号兑换',
  //         style: AppThemes.of().w400Text132,
  //       ),
  //     ),
  //   );
  // }
}

