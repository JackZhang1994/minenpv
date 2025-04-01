/*
* @overview: 路由-公共模块
* @Author: rcc 
* @Date: 2024-06-06 23:12:28 
*/

import 'package:get/get.dart';

import '/pages/home/index.dart';
import '/pages/public/splash_screen/index.dart';

final List<GetPage> publicRoutes = [
  GetPage(
    name: '/',
    binding: SplashScreenPageBinding(),
    page: () => const SplashScreenPage(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: '/home',
    binding: HomePageBinding(),
    page: () => const HomePage(),
    transition: Transition.noTransition,
  ),
];
