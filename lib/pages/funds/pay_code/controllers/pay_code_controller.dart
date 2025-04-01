/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 21:44:43 
*/

import 'package:get/get.dart';

import '/controllers/base/app_getx_controller.dart';


class PayCodeController extends AppGetxController {
  static PayCodeController get to => Get.find<PayCodeController>();

  final RxString payCode = ''.obs;
}
