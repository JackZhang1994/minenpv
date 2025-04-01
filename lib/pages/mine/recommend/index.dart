import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/widgets/public/app_top_bar.dart';
import '/widgets/public/app_scaffold.dart';

import 'widgets/recommend_view.dart';
import 'controllers/recommend_controller.dart';

class RecommendPage extends StatelessWidget {
  const RecommendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      appBar: AppTopBar(
        title: '热门推荐',
      ),
      body: SingleChildScrollView(
        child: RecommendView(),
      ),
    );
  }
}

class RecommendPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RecommendController>(RecommendController());
  }
}
