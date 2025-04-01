/*
* @overview: 中间件-登录验证
* @Author: rcc 
* @Date: 2024-06-23 12:42:24 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/controllers/public/app_user_controller.dart';

class LoginMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (AppUserController.to.isLogin) {
      return null;
    } else {
      return const RouteSettings(name: '/login');
    }
  }
}
