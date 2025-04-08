/*
 * @Author: rcc
 * @Date: 2024-08-29 19:59:51
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:yunyou_desktop/utils/app_utils.dart';

import '../../../../controllers/base/app_getx_controller.dart';
import '../models/menu_entity.dart';

class SettingController extends AppGetxController {
  static SettingController get to => Get.find<SettingController>();

  late List<MenuEntity> menuList = [
    MenuEntity(
      imgPath: 'assets/images/mine/app_setting_menu1.png',
      title: '变更国家与地区',
      onTap: () {
        Get.toNamed('/node');
      },
    ),
    MenuEntity(
      imgPath: 'assets/images/mine/app_setting_menu2.png',
      title: '消息中心',
      onTap: () {
        Get.toNamed('/message');
      },
    ),
    MenuEntity(
      imgPath: 'assets/images/mine/app_setting_menu3.png',
      title: '软件防丢失',
      onTap: () {},
    ),
    MenuEntity(
      imgPath: 'assets/images/mine/app_setting_menu4.png',
      title: '在线客服',
      onTap: () {},
    ),
    MenuEntity(
      imgPath: 'assets/images/mine/app_setting_menu5.png',
      title: '反馈问题',
      onTap: () {},
    ),
  ];

  /// 开机启动
  RxBool islaunchStart = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (!AppUtils.isMobile()) {
      _onInit();
    }
  }

  Future<void> _onInit() async {
    debugPrint('onInit SettingController');
    bool isEnabled = await launchAtStartup.isEnabled();
    islaunchStart.value = isEnabled;
  }

  Future<void> setLaunchStart(isStart) async {
    if (isStart) {
      await launchAtStartup.enable();
    } else {
      await launchAtStartup.disable();
    }
  }
}
