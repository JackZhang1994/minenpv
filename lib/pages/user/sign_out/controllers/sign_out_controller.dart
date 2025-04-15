import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/public/app_node_controller.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';
import 'package:yunyou_desktop/models/message_model.dart';

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
    closeKeyboard();
    switchClickStatus(false);

    const String url = '/api/public/remove';

    final result = await RcHttp.get<MessageModel>(
      url,
      cancelToken: cancelToken,
      errorJson: () => MessageModel.init(),
      fromJson: (json) => MessageModel.fromJson(json),
    );

    switchClickStatus(true);

    if (result.code == 200) {
      await Future.wait([
        AppUserController.to.resetUser(),
        AppNodeController.to.resetNodes(),
      ]);

      RcTag.updateTag();
      Get.offAllNamed('/home');
    } else {
      RcToast(result.msg);
    }
  }
}
