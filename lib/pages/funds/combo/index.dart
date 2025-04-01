/*
* @overview: 资金-购买套餐
* @Author: rcc 
* @Date: 2024-06-09 09:22:07 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/widgets/public/app_top_bar.dart';
import '/widgets/public/app_scaffold.dart';

import 'widgets/tab_viwe.dart';
import 'widgets/combo_view.dart';
import 'controllers/acombo_controller.dart';

class ComboPage extends StatelessWidget {
  const ComboPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      appBar: AppTopBar(
        title: '购买套餐',
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabView(),
            SizedBox(height: 20),
            ComboView(),
          ],
        ),
      ),
    );
  }
}

class ComboPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ComboController>(ComboController());
  }
}
