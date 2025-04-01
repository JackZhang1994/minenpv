/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 14:15:28 
*/

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/public/app_node_controller.dart';

import '/models/message_model.dart';
import '/controllers/base/app_getx_controller.dart';
import '/controllers/public/app_user_controller.dart';

class LoginController extends AppGetxController {
  static LoginController get to => Get.find<LoginController>();

  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController verifycode = TextEditingController();
  RxBool isShowPassword = true.obs;
  @override
  void onClose() {
    password.dispose();
    verifycode.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('LoginController onInit');
  }

  /// 表单验证
  bool isNotAllow() {
    if (isNotClick) return true;

    if (phone.text.isEmpty) {
      RcToast('请输入邮箱');
      return true;
    }

    //在isShowPassword为true时，需要验证密码,false时校验verifycode
    if (isShowPassword.value) {
      if (password.text.isEmpty) {
        RcToast('请输入密码');
        return true;
      }
    } else {
      if (verifycode.text.isEmpty) {
        RcToast('请输入验证码');
        return true;
      }
    }
    return false;
  }

  /// 表单提交
  Future<void> submit() async {
    const String url = '/api/public/login';

    if (isNotAllow()) return;
    closeKeyboard();
    switchClickStatus(false);

    final Map<String, dynamic> data = {
      "platform": AppUserController.to.platform,
      'deviceId': AppUserController.to.deviceId,
      'partnerId': 1,
      'email': phone.text,
      if (isShowPassword.value)
        'password': password.text
      else
        'code': verifycode.text,
    };

    final result = await RcHttp.post<MessageModel>(
      url,
      data: data,
      cancelToken: cancelToken,
      errorJson: () => MessageModel.init(),
      fromJson: (json) => MessageModel.fromJson(json),
    );

    if (result.code == 200) {
      await Future.delayed(const Duration(milliseconds: 300));
      await Future.wait([
        RcStorage.remove('nodes'),
        AppUserController.to.setToken(result.data),
        AppUserController.to.getUser(),
        AppNodeController.to.initNodes(),
      ]);

      RcTag.updateTag();
      Get.toNamed('/home');
    } else {
      RcToast(result.msg);
    }

    switchClickStatus(true);
  }

  /// 游客登录
  Future<void> guestLogin() async {
    const String url = '/api/public/login';
    switchClickStatus(false);
    final Map<String, dynamic> data = {
      // 如果在开发模式 则使用 88888888
      // 如果在生产模式 则使用 deviceId
      "platform": AppUserController.to.platform,
      'deviceId': kDebugMode ? 88888888 : AppUserController.to.deviceId,
      'partnerId': 1,
    };
    final result = await RcHttp.post<MessageModel>(
      url,
      data: data,
      cancelToken: cancelToken,
      errorJson: () => MessageModel.init(),
      fromJson: (json) => MessageModel.fromJson(json),
    );

    if (result.code == 200) {
      print(
        'get token in login controller: ${result.data}',
      );
      await AppUserController.to.setToken(result.data);
      await AppUserController.to.getUser();
      await AppNodeController.to.initNodes();
      Get.toNamed('/home');
    } else {
      RcToast(result.msg);
    }
    switchClickStatus(true);
  }
}
