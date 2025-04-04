import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';

class AppMenuIcon extends StatelessWidget {
  const AppMenuIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Get.toNamed('/mine'),
      child: SizedBox(
        width: 32.w,
        height: 32.w,
        child: Icon(
          Icons.menu_rounded,
          color: AppThemes.of().colors.text2,
          size: 20.w,
        ),
      ),
    );
    // 'assets/images/home/icon_menu.webp'
  }
}
