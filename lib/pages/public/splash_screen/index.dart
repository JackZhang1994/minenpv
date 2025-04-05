/*
* @overview: 公共-启动页
* @Author: rcc 
* @Date: 2024-06-06 23:13:16 
*/

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';

import '/widgets/public/app_scaffold.dart';
import 'controllers/splash_screen_controller.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    // RcScreenAdapt.init(context);
    return AdaptiveBuilder(
      defaultBuilder: (BuildContext context, Screen screen) {
        return const Placeholder();
      },
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (BuildContext context, Screen screen) {
          return Image.asset(
            'assets/images/public/app_splash_bg.png',
            fit: BoxFit.cover,
            width: 1.sw,
            height: 1.sh,
          );
        },
        desktop: (BuildContext context, Screen screen) {
          return AppScaffold(
            body: SizedBox.expand(
              child: Container(
                color: Color(0xFF08232D),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      // padding: EdgeInsets.all(20.w),
                      child: Image.asset(
                        'assets/images/public/splash_bg.png',
                        fit: BoxFit.fill,
                        // width: 800,
                        height: 571,
                      ),
                    ),
                    // Text(
                    //   '轻触连接世界',
                    //   style: AppThemes.of().w400Text136,
                    // ),
                    // SizedBox(height: 60.h),
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

class SplashScreenPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashScreenController>(SplashScreenController());
  }
}
