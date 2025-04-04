/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-23 16:40:35 
*/

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';

class GiftView extends StatelessWidget {
  const GiftView(this.onTap, {super.key});

  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 580.w,
        height: 480.h,
        padding: AppSpacings.all32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.sp),
        ),
        child: Column(
          children: [
            _buildTitle(),
            _buildMain(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.center,
      height: 88.h,
      margin: EdgeInsets.only(bottom: 32.h),
      child: Text(
        '领取每日礼包',
        style: TextStyle(
          fontSize: 48.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMain() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildText(),
        _buildButton(
          icon: 'alipay',
          name: '支付宝',
          type: 1,
        ),
      ],
    );
  }

  Widget _buildText() {
    return Text(
      '免费赠送您15分钟VIP体验\n每日都可以免费领取VIP时间\n点击下方按钮立刻领取',
      style: AppThemes.of().w500Text236,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildButton({
    required String icon,
    required String name,
    required int type,
  }) {
    return RcGestureDetector(
      onTap: () => onTap(type),
      child: Container(
          width: double.infinity,
          margin: AppSpacings.all20,
          padding: AppSpacings.all20,
          decoration: AppThemes.of().card4,
          child: const Text(textAlign: TextAlign.center, '立即领取')),
    );
  }
}
