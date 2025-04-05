/*
* @overview: 程序入口
* @Author: rcc 
* @Date: 2024-06-06 23:15:23 
*/

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yunyou_desktop/configs/index.dart';
import 'package:yunyou_desktop/utils/app_utils.dart';

import '/configs/http.dart';
import 'app.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!AppUtils.isMobile()) {
    await _initDesktopAppsPlugins();
  } else {
    await _initMobileAppsPlugins();
  }

  await Future.wait([
    ScreenUtil.ensureScreenSize(),
    RcOrientation.setLandscape(),
    RcHttp.init(
      options: HttpConfigs.options,
      onRequest: HttpConfigs.onRequest(),
      onResponse: HttpConfigs.onResponse(),
    ),
  ]);

  RcTag.initTag();
  RcToast.init(
    theme: RcToastTheme.light(),
    callBack: () => Get.overlayContext!,
  );

  runApp(const MyApp());
}

Future _initMobileAppsPlugins() async {}

Future _initDesktopAppsPlugins() async {
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
    final availableVersion = await WebViewEnvironment.getAvailableVersion();
    if (availableVersion != null) {
      await WebViewEnvironment.create(
          settings: WebViewEnvironmentSettings(
        additionalBrowserArguments: kDebugMode ? '--enable-features=msEdgeDevToolsWdpRemoteDebugging' : null,
        userDataFolder: 'flutter_browser_app',
      ));
    } else {
      print('Failed to find an installed WebView2 runtime or non-stable Microsoft Edge installation.');
    }
  }

  final directory = await getApplicationSupportDirectory();
  print('Shared Preferences Path: ${directory.path}');

  ///开机自启动
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  launchAtStartup.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
    // 设置 packageName 参数以支持 MSIX。
    packageName: 'com.70mile.vpn.desktop',
  );

  // 必须加上这一行。
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    minimumSize: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
    title: AppConfigs.appDisplayName,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}
