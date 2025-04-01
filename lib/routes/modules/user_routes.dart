/*
* @overview: 路由-用户模块
* @Author: rcc 
* @Date: 2024-06-06 23:12:28 
*/

import 'package:get/get.dart';

import '/pages/user/login/index.dart';
import '/pages/user/register/index.dart';

final List<GetPage> userRoutes = [
  GetPage(
    name: '/login',
    binding: LoginPageBinding(),
    page: () => const LoginPage(),
  ),
  GetPage(
    name: '/register',
    binding: RegisterPageBinding(),
    page: () => const RegisterPage(),
  ),
];
