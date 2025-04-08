/*
* @overview: 用户-注册页
* @Author: rcc 
* @Date: 2024-06-08 20:56:34 
*/

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';
import '/widgets/public/app_scaffold.dart';
import '/widgets/public/app_top_bar.dart';
import 'controllers/register_controller.dart';
import 'widgets/app/app_button_view.dart';
import 'widgets/app/app_form_view.dart';
import 'widgets/app/app_title_view.dart';
import 'widgets/pc/button_view.dart';
import 'widgets/pc/form_view.dart';
import 'widgets/pc/tips_view.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                      AppButtonView(),
                      // const Spacer(),
                      // AppTipsView(),
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
              title: '注册账号',
            ),
            body: SingleChildScrollView(
              padding: AppSpacings.h48,
              child: const Column(
                children: [
                  FormView(),
                  ButtonView(),
                  TipsView(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RegisterPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController());
  }
}
