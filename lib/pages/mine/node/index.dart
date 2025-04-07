/*
* @overview: 节点页
* @Author: rcc 
* @Date: 2024-06-08 21:39:20 
*/

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:get/get.dart';

import '/widgets/public/app_scaffold.dart';
import '/widgets/public/app_top_bar.dart';
import 'controllers/node_controller.dart';
import 'widgets/app/app_node_view.dart';
import 'widgets/app/app_switch_view.dart';
import 'widgets/pc/node_view.dart';
import 'widgets/pc/switch_view.dart';

class NodePage extends StatelessWidget {
  const NodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (BuildContext context, Screen screen) {
        return const Placeholder();
      },
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (BuildContext context, Screen screen) {
          return Scaffold(
            backgroundColor: Color(0xffF8F8F8),
            appBar: AppTopBar(title: '变更国家与地区', isMobile: true),
            body: Column(
              children: [
                AppSwitchView(),
                AppNodeView(),
              ],
            ),
          );
        },
        desktop: (BuildContext context, Screen screen) {
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
        },
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
