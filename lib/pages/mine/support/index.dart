/*
* @overview: 客服页
* @Author: rcc 
* @Date: 2024-06-09 20:27:36 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/widgets/public/app_top_bar.dart';
import '/widgets/public/app_scaffold.dart';

import 'widgets/webview.dart';
import 'controllers/support_controller.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      appBar: AppTopBar(
        title: '在线客服',
      ),
      body: WebView(),
    );
  }
}

class SupportPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SupportController>(SupportController());
  }
}
