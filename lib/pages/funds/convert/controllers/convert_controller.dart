/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 20:35:22 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/models/message_model.dart';
import '/controllers/base/app_getx_controller.dart';
import '/controllers/public/app_user_controller.dart';

class ConvertController extends AppGetxController {
  static ConvertController get to => Get.find<ConvertController>();

  final TextEditingController code = TextEditingController();

  @override
  void onClose() {
    code.dispose();
    super.onClose();
  }

  /// 表单验证
  bool isNotAllow() {
    if (isNotClick) return true;

    if (code.text.isEmpty) {
      RcToast('请输入兑换码');
      return true;
    }

    return false;
  }

  /// 表单提交
  Future<void> submit() async {
    const String url = '/user/exchange_check';

    if (isNotAllow()) return;
    closeKeyboard();
    switchClickStatus(false);

    final Map<String, dynamic> data = {
      'exchange_code': code.text,
    };

    final result = await RcHttp.post<MessageModel>(
      url,
      data: data,
      cancelToken: cancelToken,
      errorJson: () => MessageModel.init(),
      fromJson: (json) => MessageModel.fromJson(json),
    );

    if (result.code == 200) {
      await AppUserController.to.getUser();
      Get.back();
    }

    RcToast(result.msg);

    switchClickStatus(true);
  }
}
