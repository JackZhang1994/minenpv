import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

class AppStatusView extends StatelessWidget {
  const AppStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppUserController.to;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Obx(
          () => Visibility(
            visible: s.isVip,
            replacement: _NoVipStatusWidget(
              onTap: () {
                Get.toNamed('/combo');
              },
            ),
            child: Visibility(
              visible: s.vipType == 2,
              replacement: _VipStatusWidget(
                logoPath: 'assets/images/home/app_vip_logo.png',
                logoWidth: 88.w,
                bgPath: 'assets/images/home/vip_bg.png',
                vipName: '青铜会员',
                daysLeft: s.daysLeft,
                btnGradient: LinearGradient(colors: [Color(0xff6175FF), Color(0xff3E4AA1)]),
                onTap: () {
                  Get.toNamed('/combo');
                },
              ),
              child: _VipStatusWidget(
                logoPath: 'assets/images/home/app_svip_logo.png',
                logoWidth: 126.w,
                bgPath: 'assets/images/home/app_svip_bg.png',
                vipName: '钻石会员',
                daysLeft: s.daysLeft,
                btnGradient: LinearGradient(colors: [Color(0xffDA923F), Color(0xff7B5325)]),
                onTap: () {
                  Get.toNamed('/combo');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NoVipStatusWidget extends StatelessWidget {
  const _NoVipStatusWidget({required this.onTap});

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 129.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/home/app_no_vip_bg.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 20.r,
            spreadRadius: 0,
            color: Color(0xff003C70).withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '您还未购买套餐',
            style: AppThemes.of().medium16text1.copyWith(color: AppThemes.of().colors.primaryColor),
          ),
          AppGaps.h16,
          _ButtonView(
            btnText: '去购买',
            btnGradient: LinearGradient(colors: [Color(0xff00CCFF), AppThemes.of().colors.primaryColor!]),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class _VipStatusWidget extends StatelessWidget {
  const _VipStatusWidget({
    required this.logoPath,
    required this.logoWidth,
    required this.bgPath,
    required this.vipName,
    required this.daysLeft,
    required this.btnGradient,
    required this.onTap,
  });

  final String logoPath;

  final double logoWidth;

  final String bgPath;

  final String vipName;

  final int daysLeft;

  final LinearGradient btnGradient;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 129.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(bgPath),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 20.r,
            spreadRadius: 0,
            color: Color(0xff003C70).withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppAssetImage(logoPath, width: logoWidth, height: 41.h),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: vipName),
                    TextSpan(
                      text: ' $daysLeft ',
                      style: AppThemes.of().semibold20text1.copyWith(color: Color(0xff7B5325)),
                    ),
                    TextSpan(text: '天后到期'),
                  ],
                ),
              )
            ],
          ),
          AppGaps.h16,
          _ButtonView(
            btnText: '去续费',
            btnGradient: btnGradient,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class _ButtonView extends StatelessWidget {
  const _ButtonView({
    required this.btnText,
    required this.btnGradient,
    required this.onTap,
  });

  final String btnText;

  final LinearGradient btnGradient;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        gradient: btnGradient,
      ),
      child: RcInkWell(
        highlightColor: Colors.black12,
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              btnText,
              style: AppThemes.of().medium16text5,
            ),
            AppGaps.w8,
            AppAssetImage.square(
              'assets/images/public/app_arrow_right_white_android.png',
              dimension: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}
