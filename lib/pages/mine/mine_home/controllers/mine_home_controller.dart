/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-30 12:08:32 
*/

import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '/models/message_model.dart';
import '/controllers/base/app_getx_controller.dart';
import '/controllers/public/app_user_controller.dart';
import '/controllers/public/app_node_controller.dart';

class MineController extends AppGetxController {
  static MineController get to => Get.find<MineController>();

  Future<void> signOut() async {
    if (AppUserController.to.isNotLogin) return;

    EasyLoading.show(status: '退出中', dismissOnTap: true);

    const String url = '/logout';

    final result = await RcHttp.get<MessageModel>(
      url,
      cancelToken: cancelToken,
      errorJson: () => MessageModel.init(),
      fromJson: (json) => MessageModel.fromJson(json),
    );

    if (result.code == 200) {
      await Future.wait([
        AppUserController.to.resetUser(),
        AppNodeController.to.resetNodes(),
      ]);

      RcTag.updateTag();
      Get.offAllNamed('/home');
    }

    EasyLoading.dismiss();
  }
}
