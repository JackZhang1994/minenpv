/*
 * @Author: rcc
 * @Date: 2024-08-29 19:59:51
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_at_startup/launch_at_startup.dart';

import '../../../../controllers/base/app_getx_controller.dart';

class SettingController extends AppGetxController {
  static SettingController get to => Get.find<SettingController>();

  /// 开机启动
  RxBool islaunchStart = false.obs;

  @override
  void onInit() {
    super.onInit();

    _onInit();
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
