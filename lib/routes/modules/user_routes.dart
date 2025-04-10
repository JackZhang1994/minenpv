/*
* @overview: 路由-用户模块
* @Author: rcc 
* @Date: 2024-06-06 23:12:28 
*/

import 'package:get/get.dart';
import 'package:yunyou_desktop/pages/user/modify_pwd/index.dart';
import 'package:yunyou_desktop/pages/user/sign_out/index.dart';

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
  GetPage(
    name: '/modify_pwd',
    binding: ModifyPwdPageBinding(),
    page: () => const ModifyPwdPage(),
  ),
  GetPage(
    name: '/sign_out',
    page: () => const SignOutPage(),
    binding: SignOutPageBinding(),
  ),
];
