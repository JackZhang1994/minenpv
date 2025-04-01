/*
* @overview: 全局-系统信息
* @Author: rcc 
* @Date: 2024-06-09 18:49:00 
*/

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/models/config_model.dart';

import '/controllers/base/app_getx_controller.dart';

class AppConfigController extends AppGetxController {
  static AppConfigController get to => Get.find<AppConfigController>();
  late Config config;

  @override
  Future<void> onInit() async {
    super.onInit();
    _onInit();
  }

  void _onInit() async {
    final superId = await RcStorage.getString(RcStorageKey.superId, "");
    if (superId.isEmpty) {
      ClipboardData? clipboardData = await Clipboard.getData('text/plain');
      final text = clipboardData?.text ?? "";
      String? id = "-1";
      if (text.isNotEmpty) {
        print("第一次进入app剪贴板内容: $text");
        try {
          final uri = Uri.parse(text.toLowerCase());
          id = uri.queryParameters['superid'];
        } catch (e) {}
      }
      await RcStorage.setString(RcStorageKey.superId, id ?? "-1");
    }

    const String url = '/api/public/config';
    final result = await RcHttp.get<ConfigModel>(url,
        cancelToken: cancelToken, fromJson: (json) => ConfigModel.fromJson(json), errorJson: () => ConfigModel.init());

    if (result.code == 200) {
      config = result.data!;
    }
  }
}
