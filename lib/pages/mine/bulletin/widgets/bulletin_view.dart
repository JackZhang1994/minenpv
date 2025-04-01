/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 10:35:44 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '/themes/index.dart';
import '/controllers/public/app_user_controller.dart';

class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 500.h,
      ),
      margin: AppSpacings.h32.add(AppSpacings.t32),
      padding: AppSpacings.all32,
      decoration: AppThemes.of().card1,
      child: Column(
        children: [
          _buildTop(),
          _buildBottom(),
        ],
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      height: 48.h,
      child: Row(
        children: [
          Expanded(
            child: Text(
              '最新公告',
              style: AppThemes.of().w500Text132,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Obx(() {
            final s = AppUserController.to;
            return Text(
              // s.bulletin.date,
              '2024-06-09 10:35:44',
              style: AppThemes.of().w400Text128,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    final s = AppUserController.to;

    return Padding(
      padding: AppSpacings.t24,
      child: Obx(() {
        return Container(
          color: Colors.transparent,
          child: HtmlWidget(
            // s.bulletin.content,
            '内容',
            textStyle: AppThemes.of().w400Text328,
          ),
        );
      }),
    );
  }
}
