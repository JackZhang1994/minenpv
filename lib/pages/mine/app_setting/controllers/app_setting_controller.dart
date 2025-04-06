import 'package:get/get.dart';
import 'package:yunyou_desktop/pages/mine/app_setting/models/menu_entity.dart';

import '../../../../controllers/base/app_getx_controller.dart';

class AppSettingController extends AppGetxController {
  static AppSettingController get to => Get.find<AppSettingController>();

  late List<MenuEntity> menuList = [
    MenuEntity(
      imgPath: 'assets/images/mine/app_setting_menu1.png',
      title: '变更国家与地区',
      onTap: () {},
    ),
    MenuEntity(
      imgPath: 'assets/images/mine/app_setting_menu2.png',
      title: '消息中心',
      onTap: () {},
    ),
    MenuEntity(
      imgPath: 'assets/images/mine/app_setting_menu3.png',
      title: '软件防丢失',
      onTap: () {},
    ),
    MenuEntity(
      imgPath: 'assets/images/mine/app_setting_menu4.png',
      title: '在线客服',
      onTap: () {},
    ),
    MenuEntity(
      imgPath: 'assets/images/mine/app_setting_menu5.png',
      title: '反馈问题',
      onTap: () {},
    ),
  ];

  @override
  void onInit() {
    super.onInit();
  }
}
