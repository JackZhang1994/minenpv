/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 14:15:28 
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/utils/app_utils.dart';

import '/controllers/base/app_getx_controller.dart';
import '/models/message_model.dart';
import '../../../../controllers/public/app_user_controller.dart';

class RegisterController extends AppGetxController {
  static RegisterController get to => Get.find<RegisterController>();

  final TextEditingController phone = TextEditingController();
  final TextEditingController verifycode = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordVerify = TextEditingController();

  RxBool btnEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();

    debugPrint('RegisterController onInit');

    phone.addListener(_judgeBtnStatus);
    password.addListener(_judgeBtnStatus);
  }

  void _judgeBtnStatus() {
    btnEnabled.value = phone.text.isNotEmpty && password.text.length >= 8;
  }

  @override
  void onClose() {
    phone.removeListener(_judgeBtnStatus);
    password.removeListener(_judgeBtnStatus);
    phone.dispose();
    verifycode.dispose();
    password.dispose();
    passwordVerify.dispose();
    super.onClose();
  }

  /// 表单验证
  bool isNotAllow() {
    if (isNotClick) return true;

    if (phone.text.isEmpty) {
      RcToast('请输入账号');
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

    final Map<String, dynamic> data;
    if (AppUtils.isMobile()) {
      data = {
        'deviceId': AppUserController.to.deviceId,
        'username': phone.text,
        'password': password.text,
      };
    } else {
      data = {
        'deviceId': AppUserController.to.deviceId,
        'partnerId': 1,
        'email': phone.text,
        'code': verifycode.text,
        'password': password.text,
      };
    }

    final result = await RcHttp.post<MessageModel>(
      url,
      data: data,
      cancelToken: cancelToken,
      errorJson: () => MessageModel.init(),
      fromJson: (json) => MessageModel.fromJson(json),
    );

    if (result.code == 200) {
      RcToast('注册成功');
      // await AppUserController.to.setToken(result.data);
      // await AppUserController.to.getUser();
      // await AppNodeController.to.initNodes();
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.back();
      });
    } else {
      RcToast(result.msg);
    }

    switchClickStatus(true);
  }
}
