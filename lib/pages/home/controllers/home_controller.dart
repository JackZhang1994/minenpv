/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-10 16:10:48 
*/

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/home/models/gift_model.dart';
import 'package:yunyou_desktop/utils/app_utils.dart';

import '/controllers/base/app_getx_controller.dart';
import '/controllers/public/app_node_controller.dart';
import '/controllers/public/app_user_controller.dart';

class HomeController extends AppGetxController with GetTickerProviderStateMixin {
  static HomeController get to => Get.find<HomeController>(tag: RcTag.tag);

  late final AnimationController controller;

  @override
  void onInit() {
    super.onInit();
    debugPrint('[HomeController] onInit');
    if (!AppUtils.isMobile()) {
      controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
    }
    AppNodeController.to.initNodes();
  }

  @override
  void onClose() {
    if (!AppUtils.isMobile()) {
      controller.dispose();
    }
    print('home controller dispose');
    super.onClose();
  }

  Future<void> vpnSwitch() async {
    final s = AppNodeController.to;

    if (AppUserController.to.isNotLogin) {
      Get.toNamed('/login');
      return;
    }

    if (!AppUtils.isMobile()) {
      controller.repeat();
    } else {
      EasyLoading.show(status: s.isConnect.isTrue ? '关闭中' : '开启中');
    }

    // await Future.delayed(const Duration(milliseconds: 500));

    if (s.isConnect.value) {
      await s.stopConnect();
    } else {
      await s.startConnect();
    }

    if (!AppUtils.isMobile()) {
      controller.stop();
    } else {
      EasyLoading.dismiss();
    }
  }

  Future<void> getGift() async {
    if (AppUserController.to.isNotLogin) {
      Get.toNamed('/login');
      return;
    }
    String url = '/api/common/receive';

    final result = await RcHttp.get<GiftModel>(
      url,
      errorJson: () => GiftModel.init(),
      fromJson: (json) => GiftModel.fromJson(json),
    );
    if (result.code == 200) {
      AppUserController.to.getUser();
      RcToast(result.msg!);
    } else {
      RcToast(result.msg!);
    }
  }
}
