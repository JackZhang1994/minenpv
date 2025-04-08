import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';

import '/controllers/base/app_getx_controller.dart';
import '../screenshoot/share_screenshot_controller.dart';

class QrcodeController extends AppGetxController {
  static QrcodeController get to => Get.find<QrcodeController>();

  late ScreenshotController mScreenshotController = Get.find<ScreenshotController>();

  @override
  void onInit() {
    super.onInit();
  }

  void saveImage() {
    mScreenshotController.savePhoto(saveResult: (flag) {
      if (flag) {
        RcToast('保存成功');
      } else {
        RcToast('保存失败');
      }
    });
  }
}
