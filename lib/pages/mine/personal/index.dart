/*
* @overview: 我的-个人信息
* @Author: rcc 
* @Date: 2024-06-08 22:25:07 
*/

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/mine/personal/widgets/app/app_device_management_view.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

import '/themes/index.dart';
import '/widgets/public/app_scaffold.dart';
import '/widgets/public/app_top_bar.dart';
import 'controllers/personal_controller.dart';
import 'widgets/app/app_user_info_view.dart';
import 'widgets/pc/card_view.dart';
import 'widgets/pc/loginout_view.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (BuildContext context, Screen screen) {
        return const Placeholder();
      },
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (BuildContext context, Screen screen) {
          return Scaffold(
            backgroundColor: Color(0xffF8F8F8),
            appBar: AppTopBar(
              title: '我的账户',
              isMobile: true,
              actions: RcInkWell(
                onTap: () {
                  Get.toNamed('/account_setting');
                },
                child: AppAssetImage.square(
                  'assets/images/mine/app_setting.png',
                  dimension: 24.w,
                ),
              ),
            ),
            body: Column(
              children: [
                AppUserInfoView(),
                AppDeviceManagementView(),
              ],
            ),
          );
        },
        desktop: (BuildContext context, Screen screen) {
          return AppScaffold(
            appBar: const AppTopBar(
              title: '个人信息',
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 100.w),
              child: Container(
                margin: AppSpacings.h48,
                child: const Column(
                  children: [
                    TopCard(),
                    CenterCard(),
                    BottomCard(),
                    LoginoutView(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PersonalPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PersonalController>(PersonalController());
  }
}
