/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 22:27:10 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';
import '/widgets/base/app_asset_image.dart';
import '/controllers/public/app_user_controller.dart';

class TopCard extends StatelessWidget {
  const TopCard({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppUserController.to;

    return Container(
      width: double.infinity,
      height: 108.h,
      margin: AppSpacings.t32,
      padding: AppSpacings.h24,
      decoration: AppThemes.of().card1,
      child: Row(
        children: [
          Flexible(
              child: Text(
            '设备ID：${s.deviceId}',
            // '11',
            style: AppThemes.of().w400Text128,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          RcTextButton(
            text: '复制',
            margin: AppSpacings.h16,
            padding: AppSpacings.h16v8,
            style: AppThemes.of().w400Text528,
            borderRadius: BorderRadius.circular(4.sp),
            onTap: () async {
              final isSuccess = await RcTools.copyText(s.deviceId.toString());

              RcToast(isSuccess ? '已复制到剪切板' : '复制失败');
            },
          ),
        ],
      ),
    );
  }
}

class CenterCard extends StatelessWidget {
  const CenterCard({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppUserController.to;

    return Container(
      width: double.infinity,
      margin: AppSpacings.t32,
      padding: AppSpacings.h32,
      decoration: AppThemes.of().card1,
      child: Obx(() {
        return Column(
          children: [
            CardView(
              border: false,
              label: '用户名',
              value: s.user.uid.toString(),
              actions: const SizedBox.shrink(),
            ),
            Row(
              children: [
                SizedBox(
                  width: 300.w,
                  child: CardView(
                    border: false,
                    label: '邮箱',
                    value: s.user.email != null
                        ? s.user.email.toString()
                        : '未设置',
                    actions: const SizedBox.shrink(),
                  ),
                ),
                if (s.user.email == null)
                  RcTextButton(
                    text: '绑定',
                    margin: AppSpacings.h16,
                    padding: AppSpacings.h16v8,
                    style: AppThemes.of().w400Text528,
                    borderRadius: BorderRadius.circular(4.sp),
                    onTap: () => Get.toNamed('/register'),
                  )
              ],
            )
          ],
        );
      }),
    );
  }
}

class BottomCard extends StatelessWidget {
  const BottomCard({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppUserController.to;

    return Container(
      width: double.infinity,
      margin: AppSpacings.t32,
      padding: AppSpacings.h32,
      decoration: AppThemes.of().card1,
      child: Obx(() {
        return Column(
          children: [
            CardView(
              label: '会员等级',
              value: s.user.vipType.toString(),
            ),
            // CardView(
            //   label: '钱包余额',
            //   value: s.balance,
            // ),
            CardView(
              label: '到期时间',
              value: s.user.vipEndTime.toString(),
            ),
            // CardView(
            //   label: '设备数量',
            //   // value: '${s.device}台',
            //   value: 1.toString(),
            //   border: false,
            // ),
            // CardView(
            //   label: '设备1- ID',
            //   value: '98209482',
            //   border: false,
            //   actions: Text(
            //     '本机',
            //     style: AppThemes.of().w400Text128,
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}

class CardView extends StatelessWidget {
  const CardView({
    super.key,
    required this.label,
    required this.value,
    this.actions,
    this.border = true,
  });

  final bool border;
  final String label;
  final String value;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 108.h,
      decoration: border ? AppThemes.of().bottomBorder3 : null,
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label：$value',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppThemes.of().w400Text128,
            ),
          ),
          actions ??
              AppAssetImage.square(
                'assets/images/public/arrow-1.webp',
                dimension: 32.w,
              ),
        ],
      ),
    );
  }
}
