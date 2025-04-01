/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 10:15:36 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '../../../controllers/public/app_user_controller.dart';
import '/themes/index.dart';
import '/widgets/base/app_asset_image.dart';
import '/controllers/public/app_node_controller.dart';

import '../controllers/home_controller.dart';
import 'gift_view.dart';

class SwitchView extends StatelessWidget {
  const SwitchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home/bg-1.png'),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Column(
        children: [
          _buildStatusText(),
          // _buildSwitch(),
          _buildDailyGift(),
        ],
      ),
    );
  }

  Widget _buildSwitch() {
    return RcGestureDetector(
      onTap: HomeController.to.vpnSwitch,
      child: Container(
        width: 528.w,
        height: 528.h,
        margin: EdgeInsets.only(top: 30.h, bottom: 60.h),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildBackdrop(),
            _buildText(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackdrop() {
    final s = HomeController.to;
    final v = AppNodeController.to;
    return RotationTransition(
        turns: s.controller,
        child: Obx(
          () {
            return AppAssetImage.square(
              v.isConnect.value
                  ? 'assets/images/home/bg-2.webp'
                  : 'assets/images/home/bg-1.webp',
              dimension: double.infinity,
            );
          },
        ));
  }

  Widget _buildText() {
    final s = AppNodeController.to;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return AppAssetImage.square(
            s.isConnect.value
                ? 'assets/images/home/linked.webp'
                : 'assets/images/home/link.webp',
            dimension: 96.w,
          );
        }),
        AppGaps.h16,
        Obx(() {
          return Text(
            s.isConnect.value ? '已连接' : '点击连接',
            style: AppThemes.of().w400Text136,
          );
        }),
      ],
    );
  }

  Widget _buildStatusText() {
    final v = AppUserController.to;
    return Container(
      margin: AppSpacings.all32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10.w,
          ),
          // Obx(() {
          //   return Text(
          //     '网络：${s.nodeName}',
          //     style: AppThemes.of().w400Text128,
          //   );
          // }),
          Obx(() {
            return v.isVip
                ? Text.rich(
                    TextSpan(
                      text: '会员',
                      style: AppThemes.of().w400Text128,
                      children: [
                        TextSpan(
                          text: ' ${v.daysLeft} ',
                          style: AppThemes.of().w400Text128,
                        ),
                        TextSpan(
                          text: '天后过期',
                          style: AppThemes.of().w400Text128,
                        ),
                      ],
                    ),
                  )
                : Text('会员已到期', style: AppThemes.of().w400Text128);
          })
        ],
      ),
    );
  }
}

Widget _buildDailyGift() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(),
      RcGestureDetector(
          onTap: () async {
            print('1');
            await openPopup();
          },
          child: Container(
            margin: AppSpacings.all20,
            child: Column(
              children: [
                Container(
                  child: AppAssetImage.square(
                    'assets/images/public/gift.png',
                    dimension: 100.w,
                  ),
                ),
                AppGaps.h16,
                Container(
                    child: Text('免费领取会员', style: AppThemes.of().w400Text128))
              ],
            ),
          ))
    ],
  );
}

Future<void> openPopup() async {
  showDialog(
    context: Get.overlayContext!,
    builder: (_) {
      return GiftView((type) {
        HomeController.to.getGift();
        Get.back();
      });
    },
  );
}
