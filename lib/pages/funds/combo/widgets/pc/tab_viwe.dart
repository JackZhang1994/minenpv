/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 09:24:55 
*/

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';
import '../../controllers/acombo_controller.dart';

class TabView extends StatelessWidget {
  const TabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: TabBar(
        dividerHeight: 0,
        onTap: ComboController.to.onTabChange,
        indicator: const BoxDecoration(),
        labelStyle: AppThemes.of().w500Text132,
        labelColor: AppThemes.of().colors.text1,
        unselectedLabelColor: AppThemes.of().colors.text3,
        tabs: const [
          Tab(text: 'VIP套餐'),
          Tab(text: 'SVIP套餐'),
        ],
      ),
    );
  }
}
