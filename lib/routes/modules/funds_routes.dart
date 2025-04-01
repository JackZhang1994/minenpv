/*
* @overview: 路由-资金模块
* @Author: rcc 
* @Date: 2024-06-06 23:12:28 
*/

import 'package:get/get.dart';

import '/pages/funds/combo/index.dart';
import '/pages/funds/convert/index.dart';
import '/pages/funds/pay_code/index.dart';

import '../middlewares/login_middleware.dart';

final List<GetPage> fundsRoutes = [
  GetPage(
    name: '/convert',
    middlewares: [
      LoginMiddleware(),
    ],
    binding: ConvertPageBinding(),
    page: () => const ConvertPage(),
  ),
  GetPage(
    name: '/combo',
    middlewares: [
      LoginMiddleware(),
    ],
    binding: ComboPageBinding(),
    page: () => const ComboPage(),
  ),
  GetPage(
    name: '/pay_code',
    middlewares: [
      LoginMiddleware(),
    ],
    binding: PayCodePageBinding(),
    page: () => const PayCodePage(),
  ),
];
