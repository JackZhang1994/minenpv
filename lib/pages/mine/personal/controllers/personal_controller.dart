import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/models/message_model.dart';
import 'package:yunyou_desktop/pages/mine/personal/models/device_list_model.dart';
import 'package:yunyou_desktop/utils/app_utils.dart';

import '../../../../controllers/base/app_getx_controller.dart';

class PersonalController extends AppGetxController {
  static PersonalController get to => Get.find<PersonalController>();

  var pwdVisible = false.obs;

  void changePwdVisibility() {
    pwdVisible.value = !pwdVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    if (AppUtils.isMobile()) {
      _getDeviceList();
    }
  }

  void _getDeviceList() async {
    switchLoadStatus(LoadStatus.load);
    const String url = '/api/device/list';
    final result = await RcHttp.get<DeviceListModel>(
      url,
      cancelToken: cancelToken,
      fromJson: (json) => DeviceListModel.fromJson(json),
      errorJson: () => DeviceListModel.init(),
    );
    if (result.code == 200) {
      switchLoadStatus(LoadStatus.success);
    } else {
      switchLoadStatus(LoadStatus.error);
      RcToast(result.msg);
    }
  }

  void removeDevice(String id) async {
    EasyLoading.show(status: '请稍后', dismissOnTap: true);

    String url = '/api/device/remove/$id';
    final result = await RcHttp.get<MessageModel>(
      url,
      cancelToken: cancelToken,
      fromJson: (json) => MessageModel.fromJson(json),
      errorJson: () => MessageModel.init(),
    );
    if (result.code == 200) {
      // TODO 执行List的remove操作
    } else {
      RcToast(result.msg);
    }

    EasyLoading.dismiss();
  }
}
