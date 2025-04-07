/*
 * @Author: rcc
 * @Date: 2024-08-18 02:44:55
 */
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/home/widgets/app/app_status_view.dart';

import '../../../themes/index.dart';
import '../../../widgets/public/app_scaffold.dart';
import '../../../widgets/public/app_top_bar.dart';
import 'controllers/setting_controller.dart';
import 'widgets/app/app_menu_view.dart';
import 'widgets/app/app_personal_info_view.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final s = SettingController.to;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (BuildContext context, Screen screen) {
        return const Placeholder();
      },
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (BuildContext context, Screen screen) {
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
                      const Spacer(),
                      AppStatusView(),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        desktop: (BuildContext context, Screen screen) {
          return AppScaffold(
            appBar: const AppTopBar(
              title: '设置中心',
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 180.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '开机启动',
                        style: AppThemes.of().w400Text148,
                      ),
                      Obx(() {
                        return _buildSwitch();
                      })
                    ],
                  ),
                  Container(
                      margin: AppSpacings.t32,
                      child: Text(
                        '占用系统资源较少,建议开启开机自动启动',
                        style: AppThemes.of().w400Text132,
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSwitch() {
    return Container(
        height: 60.h,
        padding: AppSpacings.h32,
        child: Transform.scale(
          scale: 0.8,
          child: Switch.adaptive(
            value: s.islaunchStart.value,
            activeColor: Colors.white,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0x7f6FEED2),
            activeTrackColor: const Color(0xff6FEED2),
            onChanged: (value) {
              SettingController.to.setLaunchStart(value);
              debugPrint('press self_staring switch$value');
              setState(() {
                s.islaunchStart.value = value;
              });
            },
          ),
        ));
  }
}

class SettingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingController>(SettingController());
  }
}
