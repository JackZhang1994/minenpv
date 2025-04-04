/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 10:16:15 
*/

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/public/app_node_controller.dart';
import 'package:yunyou_desktop/pages/home/controllers/home_controller.dart';

import '/themes/index.dart';
import '/widgets/base/app_asset_image.dart';
import '/controllers/public/app_user_controller.dart';

class ButtonView extends StatelessWidget {
  const ButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppNodeController.to;
    final v = AppUserController.to;
    return Column(
      children: [
        if (kDebugMode || kProfileMode)
          Obx(() {
            return SelectableText('vm url :${v.url}');
          }),
        // Obx(() {
        //   return _buildButton(
        //     text: '网络：${s.nodeName}',
        //     link: '/node',
        //   );
        // }),
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                text: '网络：${s.nodeName}',
                link: '/node',
              ),
              SizedBox(width: 200.w),
              _buildButton(
                text: s.isConnect.value ? '已连接' : '点击连接',
                onTap: () => HomeController.to.vpnSwitch(),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    String? link,
    VoidCallback? onTap,
  }) {
    final s = AppNodeController.to;
    final isConnectButton = text.contains('已连接') || text.contains('点击连接');

    return GestureDetector(
      onTap: onTap ?? (link != null ? () => Get.toNamed(link) : null),
      child: Container(
        width: 360.w,
        height: 108.h,
        margin: AppSpacings.b16,
        padding: AppSpacings.h48,
        decoration: isConnectButton
            ? (s.isConnect.value
                ? AppThemes.of().button5
                : AppThemes.of().button4)
            : AppThemes.of().button4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                text,
                style: AppThemes.of().w400Text128,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AppGaps.w8,
            AppAssetImage.square(
              'assets/images/public/arrow-1.webp',
              dimension: 24.w,
            ),
          ],
        ),
      ),
    );
  }
}
