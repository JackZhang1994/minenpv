import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/public/app_node_controller.dart';
import 'package:yunyou_desktop/pages/home/controllers/home_controller.dart';

class AppSwitchView extends StatelessWidget {
  const AppSwitchView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppNodeController.to;
    return Center(
      child: GestureDetector(
        onTap: () {
          HomeController.to.vpnSwitch();
        },
        child: Obx(() {
          return Visibility(
            visible: s.isConnect.isTrue,
            replacement: Lottie.asset(
              'assets/images/home/lottie_default_animation.zip',
              width: 255.w,
              height: 255.w,
            ),
            child: Lottie.asset(
              'assets/images/home/lottie_open_animation.zip',
              width: 255.w,
              height: 255.w,
            ),
          );
        }),
      ),
    );
  }
}
