/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-23 16:40:35 
*/

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';
import '/widgets/base/app_asset_image.dart';

class PayView extends StatelessWidget {
  const PayView(this.onTap, {super.key});

  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 580.w,
        height: 440.h,
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
        '支付方式',
        style: TextStyle(
          fontSize: 30.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMain() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCard(
          icon: 'wechat',
          name: '微信',
          type: 2,
        ),
        _buildCard(
          icon: 'alipay',
          name: '支付宝',
          type: 1,
        ),
      ],
    );
  }

  Widget _buildCard({
    required String icon,
    required String name,
    required int type,
  }) {
    return RcGestureDetector(
      onTap: () => onTap(type),
      child: Container(
        width: 150.w,
        height: 150.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(16.sp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppAssetImage.square(
              'assets/images/public/$icon.png',
              dimension: 60.sp,
            ),
            AppGaps.h8,
            Text(
              name,
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
