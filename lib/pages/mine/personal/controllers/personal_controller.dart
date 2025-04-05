import 'package:get/get.dart';

import '../../../../controllers/base/app_getx_controller.dart';

class PersonalController extends AppGetxController {
  static PersonalController get to => Get.find<PersonalController>();

  var pwdVisible = false.obs;

  void changePwdVisibility() {
    pwdVisible.value = !pwdVisible.value;
  }
}
