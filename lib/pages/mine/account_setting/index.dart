import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/mine/mine_home/controllers/mine_home_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';
import 'package:yunyou_desktop/widgets/public/app_dialog.dart';
import 'package:yunyou_desktop/widgets/public/app_top_bar.dart';

import 'controllers/account_setting_controller.dart';

class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppTopBar(
        title: '账户设置',
        isMobile: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            Container(
              width: 1.sw,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white,
              ),
              clipBehavior: Clip.hardEdge,
              child: RcInkWell(
                onTap: () {
                  Get.dialog(
                    AppDialog(
                      title: '确定退出登录？',
                      negativeBtnText: '取消',
                      positiveBtnText: '确定',
                      onPositiveTap: () {
                        MineController.to.signOut();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      AppAssetImage.square(
                        'assets/images/mine/app_exit.png',
                        dimension: 24.w,
                      ),
                      AppGaps.w12,
                      Expanded(
                        child: Text(
                          '退出登录',
                          style: AppThemes.of().medium16text1,
                          maxLines: 1,
                        ),
                      ),
                      AppAssetImage.square(
                        'assets/images/public/app_arrow_right_grey.png',
                        dimension: 20.w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AppGaps.h12,
            Container(
              width: 1.sw,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white,
              ),
              clipBehavior: Clip.hardEdge,
              child: RcInkWell(
                onTap: () {
                  Get.toNamed('/sign_out');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      AppAssetImage.square(
                        'assets/images/mine/app_sign_out.png',
                        dimension: 24.w,
                      ),
                      AppGaps.w12,
                      Expanded(
                        child: Text(
                          '注销账户',
                          style: AppThemes.of().medium16text1,
                          maxLines: 1,
                        ),
                      ),
                      AppAssetImage.square(
                        'assets/images/public/app_arrow_right_grey.png',
                        dimension: 20.w,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AccountSettingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AccountSettingController>(AccountSettingController());
  }
}
