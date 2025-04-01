/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-19 22:24:34 
*/

import 'package:get/get.dart';

import '../../../../controllers/public/app_node_controller.dart';
import '/controllers/base/app_getx_controller.dart';
// import '/controllers/public/app_node_controller.dart';

class NodeController extends AppGetxController {
  static NodeController get to => Get.find<NodeController>();

  @override
  void onInit() {
    super.onInit();

    AppNodeController.to.initNodes();
  }
}
