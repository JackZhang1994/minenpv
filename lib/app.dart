/*
* @overview: 页面入口
* @Author: rcc 
* @Date: 2024-06-06 23:16:17 
*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yunyou_desktop/controllers/public/app_config_controller.dart';
import 'package:yunyou_desktop/utils/app_utils.dart';

import 'configs/index.dart';
import 'controllers/public/app_node_controller.dart';
import 'controllers/public/app_user_controller.dart';
import 'pages/mine/mine_home/controllers/mine_home_controller.dart';
import 'routes/index.dart';
import 'themes/index.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WindowListener, TrayListener {
  @override
  void initState() {
    super.initState();
    if (!AppUtils.isMobile()) {
      trayManager.addListener(this);
      windowManager.addListener(this);
      _init();
    }
  }

  @override
  void dispose() {
    if (!AppUtils.isMobile()) {
      trayManager.removeListener(this);
      windowManager.removeListener(this);
    }
    super.dispose();
  }

  void _init() async {
    // 添加此行以覆盖默认关闭处理程序
    await windowManager.setPreventClose(true);
    await trayManager.setIcon(
      Platform.isWindows ? 'assets/icons/tray-icon.ico' : 'assets/icons/tray-icon.png',
    );
    Menu menu = Menu(
      items: [
        // MenuItem(
        //   key: '111111',
        //   label: '111111',
        // ),
        MenuItem(
          key: 'set_open_node',
          label: '系统代理',
        ),
        MenuItem.separator(),
        MenuItem(
          key: 'exit_app',
          label: '退出程序',
        ),
      ],
    );
    await trayManager.setContextMenu(menu);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Breakpoint(
      breakpointData: BreakpointData(
        minSmallDesktopWidth: 800,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.theme,
        getPages: AppRoutes.routes,
        initialBinding: InitialBinding(),
        initialRoute: AppRoutes.initialRoute,
        defaultTransition: AppRoutes.defaultTransition,
        transitionDuration: AppRoutes.defaultTransitionDuration,
        locale: AppConfigs.defaultLocale,
        supportedLocales: AppConfigs.supportedLocales,
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: EasyLoading.init(
          builder: _buildRoot,
        ),
      ),
    );
  }

  Widget _buildRoot(BuildContext context, Widget? child) {
    ScreenUtil.init(
      context,
      designSize: AppUtils.isMobile() ? const Size(375, 812) : const Size(1800, 1200),
      minTextAdapt: true,
    );
    // RcScreenAdapt.init(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1),
      ),
      child: RcSystemStyle(
        systemOverlayStyle: RcOverlayStyle.light.copyWith(
          systemNavigationBarColor: const Color(0xff3BE5FF),
        ),
        child: RcKeyboardDismiss(
          child: child,
        ),
      ),
    );
  }

  @override
  void onTrayIconMouseDown() {
    windowManager.show();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  Future<void> onTrayMenuItemClick(MenuItem menuItem) async {
    switch (menuItem.key) {
      case 'show_window':
        await windowManager.focus();
        break;
      case 'set_open_node':
        setState(() {});
        break;
      case 'exit_app':
        windowManager.destroy();
        break;
    }
  }
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppConfigController>(AppConfigController(), permanent: true);
    Get.put<AppUserController>(AppUserController(), permanent: true);
    Get.put<AppNodeController>(AppNodeController(), permanent: true);
    Get.put<MineController>(MineController(), permanent: true);
  }
}
