/*
* @overview: 消息中心页面
* @Author: rcc 
* @Date: 2024-06-09 10:33:24 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/widgets/public/app_top_bar.dart';
import '/widgets/public/app_scaffold.dart';

import 'widgets/bulletin_view.dart';

class BulletinPage extends StatelessWidget {
  const BulletinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      appBar: AppTopBar(
        title: '消息中心',
      ),
      body: SingleChildScrollView(
        child: CardView(),
      ),
    );
  }
}

class BulletinPageBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put<>(());
  }
}
