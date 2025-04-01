/*
 * @Author: rcc
 * @Date: 2024-08-18 02:44:55
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';

import '../../../themes/index.dart';
import '../../../widgets/public/app_scaffold.dart';
import '../../../widgets/public/app_top_bar.dart';
import 'controllers/setting_controller.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final s = SettingController.to;
  @override
  Widget build(BuildContext context) {
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
        ));
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
