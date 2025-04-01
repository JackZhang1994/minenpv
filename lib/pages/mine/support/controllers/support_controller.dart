/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 21:44:43 
*/

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:yunyou_desktop/controllers/public/app_config_controller.dart';

import '/controllers/base/app_getx_controller.dart';

class SupportController extends AppGetxController {
  static SupportController get to => Get.find<SupportController>();

  late InAppWebViewController webViewController;

  final initUrl = AppConfigController.to.config.onlineService!;

  final currentUrl = "".obs;

  var progress = 0.0.obs;

  var hasError = false.obs; // 是否发生错误
  var errorMessage = ''.obs; // 错误信息

  // 刷新页面
  void reloadPage() {
    webViewController.reload();
  }

  // 返回上一页
  Future<void> goBack() async {
    if (await webViewController.canGoBack()) {
      webViewController.goBack();
    }
  }

  // 前往下一页
  Future<void> goForward() async {
    if (await webViewController.canGoForward()) {
      webViewController.goForward();
    }
  }
}
