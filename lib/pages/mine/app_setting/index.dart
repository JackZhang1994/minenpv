import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/public/app_top_bar.dart';
import 'controllers/app_setting_controller.dart';
import 'widgets/app_menu_view.dart';
import 'widgets/app_personal_info_view.dart';

class AppSettingPage extends StatelessWidget {
  const AppSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: '设置',
        isMobile: true,
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/home/home_bg.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppPersonalInfoView(),
                AppMenuView(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppSettingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppSettingController>(AppSettingController());
  }
}
