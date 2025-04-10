import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/public/app_node_controller.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';

import '/controllers/base/app_getx_controller.dart';

class SignOutController extends AppGetxController {
  static SignOutController get to => Get.find<SignOutController>();

  late TextEditingController passwordController = TextEditingController();

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

  void signOut() async {
    // TODO 注销接口
    closeKeyboard();
    switchClickStatus(false);
    await Future.delayed(Duration(seconds: 2));
    switchClickStatus(true);

    await Future.wait([
      AppUserController.to.resetUser(),
      AppNodeController.to.resetNodes(),
    ]);
    RcTag.updateTag();
    Get.offAllNamed('/home');

    // const String url = '/api/feedback/add';
    // final Map<String, dynamic> data = {
    //   'type': curFeedbackIndex.value,
    //   'email': emailController.text,
    //   'textContent': descriptionController.text,
    //   'imgContent': uploadedFilePaths.join(','),
    // };
    // final result = await RcHttp.post<MessageModel>(
    //   url,
    //   data: data,
    //   cancelToken: cancelToken,
    //   errorJson: () => MessageModel.init(),
    //   fromJson: (json) => MessageModel.fromJson(json),
    // );
    // if (result.code == 200) {
    //   RcToast('提交反馈成功');
    // } else {
    //   RcToast(result.msg);
    // }
  }
}
