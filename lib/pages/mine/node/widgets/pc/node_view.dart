/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 21:57:12 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/configs/index.dart';
import 'dart:math';

import '/themes/index.dart';
import '/models/node_model.dart';
import '/widgets/base/app_asset_image.dart';
import '/controllers/public/app_node_controller.dart';

class NodeView extends StatelessWidget {
  const NodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: AppSpacings.h32.add(AppSpacings.t32),
        decoration: AppThemes.of().card2,
        child: const MyTabbedWidget(),
        // Obx(() {
        //   return ListView.builder(
        //     itemCount: s.nodes.length,
        //     itemExtent: 96.h,
        //     padding: AppSpacings.all32,
        //     itemBuilder: (_, int index) {
        //       return Obx(() => NodeCard(s.nodes[index]));
        //     },
        //   );
        // }),
      ),
    );
  }
}

class NodeCard extends StatelessWidget {
  const NodeCard(this.data, {super.key});

  final SubscribeNode data;

  @override
  Widget build(BuildContext context) {
    final s = AppNodeController.to;

    return Obx(() {
      final isSelected = s.currentNode.value?.id == data.id;
      return RcGestureDetector(
        onTap: () => AppNodeController.to.switchNode(data),
        child: Container(
          height: 88.h,
          margin: AppSpacings.b48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: isSelected
                ? const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xff578E95),
                      Color(0xff53A368),
                    ],
                  )
                : null,
            color: isSelected ? null : const Color(0xff1C282A),
          ),
          child: Row(
            children: [
              _buildFlags(),
              SizedBox(width: 48.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildText(),
                  AppGaps.w16,
                  _buildBanner(),
                  AppGaps.w16,
                  _buildPing(),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildConnectButton(isSelected),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildFlags() {
    final String flagUrl = data.icon?.isNotEmpty == true ? AppConfigs.buildImageUrl(data.icon!) : '';

    return Container(
      width: 200.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
      ),
      child: flagUrl.isNotEmpty
          ? Image.network(
              flagUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/flags/unknown.png',
                fit: BoxFit.cover,
              ),
            )
          : Image.asset(
              'assets/images/flags/unknown.png',
              fit: BoxFit.cover,
            ),
    );
  }

  Widget _buildBanner() {
    return AppAssetImage(
      data.vipType == 1
          ? 'assets/images/flags/vip.webp'
          : 'assets/images/flags/svip.webp',
      width: 66.w,
      padding: AppSpacings.r16,
    );
  }

  Widget _buildText() {
    return Text(
      data.title!,
      style: AppThemes.of().w400Text132,
    );
  }

  Widget _buildConnectButton(bool isSelected) {
    return Container(
      margin: EdgeInsets.only(
        right: 32.w,
        bottom: 32.h,
      ),
      child: RcGestureDetector(
        onTap: () {
          AppNodeController.to.switchNode(data);
          Get.toNamed('/home');
        },
        child: Container(
          width: 220.w,
          height: 80.h,
          decoration: AppThemes.of().button3,
          alignment: Alignment.center,
          child: Text(
            '连接节点',
            style: AppThemes.of().w400Text132,
          ),
        ),
      ),
    );
  }

  Widget _buildPing() {
    final random = Random();
    final ping = 20 + random.nextInt(61); // 生成 20-80 之间的随机数

    return Text(
      '${ping}ms',
      style: AppThemes.of().w400Text132.copyWith(
            color: const Color(0xff88F7BF),
          ),
    );
  }
}

class MyTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final selectedIndex = 0.obs;
  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(
      vsync: this,
      length: 2,
      initialIndex: selectedIndex.value,
    );
    controller.addListener(() {
      selectedIndex.value = controller.index;
    });
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  void switchTab(int index) {
    selectedIndex.value = index;
    controller.animateTo(index);
  }
}

class MyTabbedWidget extends StatelessWidget {
  const MyTabbedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppNodeController.to;
    final tabx = Get.put(MyTabController());

    return Column(
      children: [
        SizedBox(
          height: 88.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildButton(
                'VIP',
                0,
                tabx,
              ),
              SizedBox(width: 32.w),
              _buildButton(
                'SVIP',
                1,
                tabx,
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabx.controller,
            children: [
              GridView.builder(
                padding: AppSpacings.all32,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 300.h,
                  crossAxisSpacing: 100.w,
                  mainAxisSpacing: 0,
                ),
                itemCount: s.nodes.length,
                itemBuilder: (_, int index) {
                  return NodeCard(s.nodes[index]);
                },
              ),
              GridView.builder(
                padding: AppSpacings.all32,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 300.h,
                  crossAxisSpacing: 100.w,
                  mainAxisSpacing: 0,
                ),
                itemCount: s.snodes.length,
                itemBuilder: (_, int index) {
                  return NodeCard(s.snodes[index]);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String text, int index, MyTabController controller) {
    return Obx(() {
      final isSelected = controller.selectedIndex.value == index;
      return RcGestureDetector(
        onTap: () => controller.switchTab(index),
        child: Container(
          width: 120.w,
          height: 60.h,
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xff578E95),
                      Color(0xff53A368),
                    ],
                  )
                : null,
            color: isSelected ? null : const Color(0xff1C282A),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: AppThemes.of().w400Text132.copyWith(
                  color: isSelected ? Colors.white : const Color(0xFFABABAB),
                ),
          ),
        ),
      );
    });
  }
}
