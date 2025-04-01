/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 11:13:10 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';

import '/themes/index.dart';


class CountView extends StatelessWidget {
  const CountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172.h,
      margin: AppSpacings.t48,
      decoration: AppThemes.of().card1,
      child: Obx(() {
        final s = AppUserController.to;

        return Row(
          children: [
            _buildCard(
              label: '成功推荐',
              unit: '人',
              value: s.user.invites.toString(),
            ),
            VerticalDivider(
              indent: 54.h,
              endIndent: 54.h,
              thickness: 1,
              color: const Color(0xffAAE2FF),
            ),
            _buildCard(
              label: '累积获得',
              unit: '秒',
              value: s.user.rewardDuration.toString(),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCard({
    required String label,
    required String unit,
    required String value,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              text: value,
              style: AppThemes.of().w700Text448,
              children: [
                TextSpan(
                  text: unit,
                  style: AppThemes.of().w400Text428,
                ),
              ],
            ),
          ),
          Text(
            label,
            style: AppThemes.of().w400Text124,
          )
        ],
      ),
    );
  }
}
