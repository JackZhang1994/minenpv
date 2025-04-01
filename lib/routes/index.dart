/*
* @overview: App-路由配置
* @Author: rcc 
* @Date: 2024-06-06 23:11:57 
*/

import 'package:get/get.dart';

import 'modules/user_routes.dart';
import 'modules/mine_routes.dart';
import 'modules/funds_routes.dart';
import 'modules/public_routes.dart';

class AppRoutes {
  AppRoutes._();

  /// 默认路由
  static const initialRoute = '/';

  /// 默认路由动画
  static const defaultTransition = Transition.rightToLeft;

  /// 默认路由动画时间
  static const defaultTransitionDuration = Duration(milliseconds: 180);

  /// 路由列表
  static final List<GetPage> routes = [
    ...userRoutes,
    ...mineRoutes,
    ...fundsRoutes,
    ...publicRoutes,
  ];
}
