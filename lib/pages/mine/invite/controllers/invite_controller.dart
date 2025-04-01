/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-10 20:56:20 
*/

import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yunyou_desktop/controllers/public/app_config_controller.dart';

import '/controllers/base/app_getx_controller.dart';
import '/controllers/public/app_user_controller.dart';

import '../models/invite_model.dart';

class InviteController extends AppGetxController {
  static InviteController get to => Get.find<InviteController>();

  final Rx<InviteInfo> invite = InviteInfo.init().obs;

  /// 邀请链接
  String get inviteUrl =>
      '${AppConfigController.to.config.website}?superId=${AppUserController.to.user.uid}&partnerId=1';

  @override
  void onInit() {
    super.onInit();

    getInvite();
  }

  Future<void> getInvite() async {
    const String url = '/getuserinviteinfo';

    EasyLoading.show(status: '加载中...');

    final result = await RcHttp.post<InviteModel>(
      url,
      cancelToken: cancelToken,
      errorJson: () => InviteModel.init(),
      fromJson: (json) => InviteModel.fromJson(json),
    );

    if (result.ret == 1) {
      invite.value = result.inviteInfo;
    }

    EasyLoading.dismiss();
  }
}
