/*
* @overview: 路由-我的模块
* @Author: rcc 
* @Date: 2024-06-06 23:12:28 
*/

import 'package:get/get.dart';
import 'package:yunyou_desktop/pages/mine/account_setting/index.dart';
import 'package:yunyou_desktop/pages/mine/message/index.dart';
import 'package:yunyou_desktop/pages/mine/message_detail/index.dart';
import 'package:yunyou_desktop/pages/mine/qrcode/index.dart';
import 'package:yunyou_desktop/utils/app_utils.dart';

import '/pages/mine/bulletin/index.dart';
import '/pages/mine/invite/index.dart';
import '/pages/mine/node/index.dart';
import '/pages/mine/personal/index.dart';
import '/pages/mine/recommend/index.dart';
import '/pages/mine/setting/index.dart';
import '/pages/mine/support/index.dart';
import '../middlewares/login_middleware.dart';

final List<GetPage> mineRoutes = [
  GetPage(
    name: '/personal',
    middlewares: [
      LoginMiddleware(),
    ],
    binding: PersonalPageBinding(),
    page: () => const PersonalPage(),
  ),
  GetPage(
    name: '/node',
    middlewares: [
      LoginMiddleware(),
    ],
    binding: NodePageBinding(),
    page: () => const NodePage(),
  ),
  GetPage(
    name: '/bulletin',
    middlewares: [
      LoginMiddleware(),
    ],
    binding: BulletinPageBinding(),
    page: () => const BulletinPage(),
  ),
  GetPage(
    name: '/invite',
    middlewares: [
      LoginMiddleware(),
    ],
    binding: InvitePageBinding(),
    page: () => const InvitePage(),
  ),
  GetPage(
    name: '/support',
    binding: SupportPageBinding(),
    page: () => const SupportPage(),
  ),
  GetPage(
    name: '/setting',
    binding: SettingPageBinding(),
    page: () => const SettingPage(),
    transition: AppUtils.isMobile() ? Transition.leftToRight : null,
  ),
  GetPage(
    name: '/recommend',
    page: () => const RecommendPage(),
    binding: RecommendPageBinding(),
  ),
  GetPage(
    name: '/account_setting',
    page: () => const AccountSettingPage(),
    binding: AccountSettingPageBinding(),
  ),
  GetPage(
    name: '/message',
    page: () => const MessagePage(),
    binding: MessagePageBinding(),
  ),
  GetPage(
    name: '/message_detail',
    page: () => const MessageDetailPage(),
  ),
  GetPage(
    name: '/qrcode',
    page: () => const QrcodePage(),
    binding: QrcodePageBinding(),
  ),
];
