/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 21:01:10 
*/

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';
import '../../../../../configs/index.dart';

class AppTipsView extends StatelessWidget {
  const AppTipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 24.h),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              RcToast('跳转服务协议');
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: '注册即表示同意', style: AppThemes.of().medium14text1),
                  WidgetSpan(child: AppGaps.w4),
                  TextSpan(text: '${AppConfigs.appDisplayName}平台服务协议', style: AppThemes.of().medium14primary)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
