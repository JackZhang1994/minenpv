import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yunyou_desktop/controllers/base/app_getx_controller.dart';

class ModifyPwdController extends AppGetxController {
  static ModifyPwdController get to => Get.find<ModifyPwdController>();

  final TextEditingController password = TextEditingController();

  /// 表单提交
  Future<void> submit() async {
    const String url = '/api/public/register';

    // if (isNotAllow()) return;
    // closeKeyboard();
    // switchClickStatus(false);
    //
    // final Map<String, dynamic> data = {
    //   "deviceId": AppUserController.to.deviceId,
    //   "partnerId": 1,
    //   "email": phone.text,
    //   "code": verifycode.text,
    //   "password": password.text,
    // };
    //
    // final result = await RcHttp.post<MessageModel>(
    //   url,
    //   data: data,
    //   cancelToken: cancelToken,
    //   errorJson: () => MessageModel.init(),
    //   fromJson: (json) => MessageModel.fromJson(json),
    // );
    //
    // if (result.code == 200) {
    //   await AppUserController.to.setToken(result.data);
    //   await AppUserController.to.getUser();
    //   await AppNodeController.to.initNodes();
    //   Get.back();
    // } else {
    //   RcToast(result.msg);
    // }

    switchClickStatus(true);
  }
}
