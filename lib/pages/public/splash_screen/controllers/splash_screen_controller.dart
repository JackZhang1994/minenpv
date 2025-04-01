/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 09:16:46 
*/

import 'package:get/get.dart';

import '/controllers/base/app_getx_controller.dart';
import '/controllers/public/app_user_controller.dart';

class SplashScreenController extends AppGetxController {
  static SplashScreenController get to => Get.find<SplashScreenController>();

  @override
  void onInit() {
    super.onInit();
    toHome();
  }

  Future<void> toHome() async {
    await Future.wait([
      AppUserController.to.getUser(),
      Future.delayed(const Duration(seconds: 2)),
    ]);
    Get.offAllNamed('/home');
  }
}
