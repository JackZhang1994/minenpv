/*
* @overview: 用户-登录页
* @Author: rcc 
* @Date: 2024-06-08 20:56:34 
*/

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';

import '/widgets/public/app_scaffold.dart';
import '/widgets/public/app_top_bar.dart';
import 'controllers/login_controller.dart';
import 'widgets/app/app_button_view.dart';
import 'widgets/app/app_form_view.dart';
import 'widgets/app/app_title_view.dart';
import 'widgets/pc/button_view.dart';
import 'widgets/pc/form_view.dart';
import 'widgets/pc/tips_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (BuildContext context, Screen screen) {
        return const Placeholder();
      },
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (BuildContext context, Screen screen) {
          return ColoredBox(
            color: Colors.white,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppThemes.of().colors.primaryColor.withOpacity(0.1),
                    AppThemes.of().colors.primaryColor.withOpacity(0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppTopBar(
                  title: '',
                  backgroundColor: Colors.transparent,
                  isMobile: true,
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.h24,
                      AppTitleView(),
                      AppGaps.h38,
                      AppFormView(),
                      AppGaps.h46,
                      Flexible(child: AppButtonView()),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        desktop: (BuildContext context, Screen screen) {
          return AppScaffold(
            appBar: const AppTopBar(
              title: '登录账号',
            ),
            body: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      left: 80.w,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Image.asset(
                          'assets/images/public/login_bg.png',
                          width: 1000.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.only(left: 1000.w, right: 48.w),
                      child: Container(
                        width: 630.w,
                        padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 32.h),
                        decoration: BoxDecoration(
                          color: Color(0xff1C282A),
                          borderRadius: BorderRadius.circular(16.sp),
                        ),
                        child: const Column(
                          children: [
                            FormView(),
                            ButtonView(),
                          ],
                        ),
                      ),
                    ),
                    // Positioned(
                    //   left: 0,
                    //   right: 0,
                    //   bottom: 48.h,
                    //   child: TipsView(),
                    // ),
                  ],
                ),
                TipsView(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LoginPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
