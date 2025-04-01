/*
* @overview: 用户-登录页
* @Author: rcc 
* @Date: 2024-06-08 20:56:34 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/widgets/public/app_top_bar.dart';
import '/widgets/public/app_scaffold.dart';

import 'widgets/form_view.dart';
import 'widgets/tips_view.dart';
import 'widgets/button_view.dart';
import 'controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 48.w, vertical: 32.h),
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
  }
}

class LoginPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
