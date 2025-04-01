/*
* @overview: 节点页
* @Author: rcc 
* @Date: 2024-06-08 21:39:20 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/widgets/public/app_top_bar.dart';
import '/widgets/public/app_scaffold.dart';

import 'widgets/node_view.dart';
import 'widgets/switch_view.dart';
import 'controllers/node_controller.dart';

class NodePage extends StatelessWidget {
  const NodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      appBar: AppTopBar(
        title: '变更国家和地区',
      ),
      body: Column(
        children: [
          SwitchView(),
          NodeView(),
        ],
      ),
    );
  }
}

class NodePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NodeController>(NodeController());
  }
}
