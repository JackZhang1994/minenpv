/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 21:44:04 
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/public/app_node_controller.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';

class SwitchView extends StatelessWidget {
  const SwitchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
      margin: AppSpacings.h32.add(AppSpacings.t32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 450.w,
            child: _buildModeCard(
              title: '智能代理',
              icon: 'assets/images/public/ai.png',
              desc: '智能的分流规则，进行加速',
              isLeft: true,
            ),
          ),
          SizedBox(width: 32.w),
          SizedBox(
            width: 450.w,
            child: _buildModeCard(
              title: '全局代理',
              icon: 'assets/images/public/global.png',
              desc: '代理所有网络访问，安全性更强',
              isLeft: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeCard({
    required String title,
    required String icon,
    required String desc,
    required bool isLeft,
  }) {
    final s = AppNodeController.to;

    return Obx(() {
      final isSelected = isLeft == !s.isProxyOnly.value;

      return RcGestureDetector(
        onTap: () => s.switchProxyMode(!isLeft),
        child: Container(
          decoration: BoxDecoration(
            gradient: !isSelected
                ? const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xff578E95),
                      Color(0xff53A368),
                    ],
                  )
                : null,
            color: !isSelected ? null : const Color(0xff001d1d),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: !isSelected ? const Color(0xff88F7BF) : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppThemes.of().w400Text132,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        desc,
                        style: AppThemes.of().w400Text128.copyWith(
                              color: Colors.white38,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset(
                icon,
                width: 150.w,
                height: 150.w,
              ),
            ],
          ),
        ),
      );
    });
  }
}
