/*
* @overview: 资金-付款码
* @Author: rcc 
* @Date: 2024-06-10 15:28:49 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';

import '../../../themes/index.dart';
import '../../../widgets/base/app_asset_image.dart';
import '/widgets/public/app_top_bar.dart';
import '/widgets/public/app_scaffold.dart';

import 'controllers/pay_code_controller.dart';

class PayCodePage extends StatelessWidget {
  const PayCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    late String name;
    late String icon;
    if (data['channelId'] == 1) {
      icon = 'alipay';
      name = '手机支付宝 扫码支付';
    } else if (data['channelId'] == 2) {
      icon = 'wechat';
      name = '手机微信 扫码支付';
    }

    return AppScaffold(
      appBar: const AppTopBar(
        title: '扫码支付',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppAssetImage.square(
              'assets/images/public/$icon.png',
              dimension: 148.sp,
            ),
            AppGaps.h16,
            Text(
              name,
              style: AppThemes.of().w700Text148,
            ),
            AppGaps.h16,
            Container(
              width: 480.w,
              height: 480.h,
              padding: AppSpacings.all32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.sp),
              ),
              child: RcQrCode(
                size: double.infinity,
                data: data['url'],
              ),
            ),
            AppGaps.h16,
            RcGestureDetector(
              onTap: () => onParsed(),
              child: Container(
                height: 100.h,
                width: 480.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.sp),
                  color: Colors.black.withOpacity(0.50),
                ),
                alignment: Alignment.center,
                margin: AppSpacings.h48,
                padding: AppSpacings.h16,
                child: Text(
                  '我已完成支付',
                  style: AppThemes.of().w400Text132,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void onParsed() {
  AppUserController.to.getUser();
  Get.back();
}

class PayCodePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PayCodeController>(PayCodeController());
  }
}
