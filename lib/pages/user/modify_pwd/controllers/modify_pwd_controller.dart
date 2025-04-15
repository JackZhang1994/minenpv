import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/base/app_getx_controller.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';
import 'package:yunyou_desktop/models/message_model.dart';

class ModifyPwdController extends AppGetxController {
  static ModifyPwdController get to => Get.find<ModifyPwdController>();

  final TextEditingController passwordController = TextEditingController();
  var btnEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(_judgeBtnStatus);
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.removeListener(_judgeBtnStatus);
  }

  void _judgeBtnStatus() {
    btnEnabled.value = passwordController.text.length >= 8;
  }

  /// 表单提交
  Future<void> submit() async {
    closeKeyboard();
    switchClickStatus(false);

    final String password = passwordController.text;

    const String url = '/api/public/update_password';
    final Map<String, dynamic> data = {'password': password};
    final result = await RcHttp.post<MessageModel>(
      url,
      data: data,
      cancelToken: cancelToken,
      errorJson: () => MessageModel.init(),
      fromJson: (json) => MessageModel.fromJson(json),
    );

    switchClickStatus(true);

    if (result.code == 200) {
      final AppUserController t = AppUserController.to;
      t.updateUser(password);
      RcToast('修改密码成功');
      Get.back();
    } else {
      RcToast(result.msg);
    }
  }
}
