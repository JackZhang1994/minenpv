/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 14:15:28 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '../../../../controllers/public/app_node_controller.dart';
import '../../../../controllers/public/app_user_controller.dart';
import '/models/message_model.dart';
import '/controllers/base/app_getx_controller.dart';

class RegisterController extends AppGetxController {
  static RegisterController get to => Get.find<RegisterController>();

  final TextEditingController phone = TextEditingController();
  final TextEditingController verifycode = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordVerify = TextEditingController();

  @override
  void onClose() {
    verifycode.dispose();
    password.dispose();
    passwordVerify.dispose();
    super.onClose();
  }

  /// 表单验证
  bool isNotAllow() {
    if (isNotClick) return true;

    if (phone.text.isEmpty) {
      RcToast('请输入邮箱');
      return true;
    }

    if (!phone.text.isEmail) {
      RcToast('邮箱格式错误');
      return true;
    }

    if (password.text.isEmpty) {
      RcToast('请输入密码');
      return true;
    }

    return false;
  }

  /// 表单提交
  Future<void> submit() async {
    const String url = '/api/public/register';

    if (isNotAllow()) return;
    closeKeyboard();
    switchClickStatus(false);

    final Map<String, dynamic> data = {
      "deviceId": AppUserController.to.deviceId,
      "partnerId": 1,
      "email": phone.text,
      "code": verifycode.text,
      "password": password.text,
    };

    final result = await RcHttp.post<MessageModel>(
      url,
      data: data,
      cancelToken: cancelToken,
      errorJson: () => MessageModel.init(),
      fromJson: (json) => MessageModel.fromJson(json),
    );

    if (result.code == 200) {
      await AppUserController.to.setToken(result.data);
      await AppUserController.to.getUser();
      await AppNodeController.to.initNodes();
      Get.back();
    } else {
      RcToast(result.msg);
    }

    switchClickStatus(true);
  }
}
