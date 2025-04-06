/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 09:39:52 
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';

import '/themes/index.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    this.leading,
    this.actions,
    this.title = '',
    this.isMobile = false,
  });

  final String title;
  final Widget? leading;
  final Widget? actions;
  final bool isMobile;

  @override
  Size get preferredSize => Size.fromHeight(isMobile ? 44.h : 88.h);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildLeading(),
            _buildTitle(),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeading() {
    final widget;
    if (isMobile) {
      widget = RcImageButton(
        name: 'assets/images/public/app_arrow_left_android.png',
        dimension: 24.w,
        imageDimension: 24.w,
        onTap: () {
          AppUserController.to.getUser();
          Get.back();
        },
      );
    } else {
      widget = RcImageButton(
        name: 'assets/images/public/back.webp',
        dimension: 88.w,
        imageDimension: 48.w,
        onTap: () {
          AppUserController.to.getUser();
          Get.back();
        },
      );
    }
    return Positioned(
      left: 12.w,
      child: leading ?? widget,
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: isMobile ? AppThemes.of().medium18text1 : AppThemes.of().w500Text136,
    );
  }

  Widget _buildActions() {
    return Positioned(
      right: 12.w,
      child: actions ?? const SizedBox.shrink(),
    );
  }
}
