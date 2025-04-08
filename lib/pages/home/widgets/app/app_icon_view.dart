import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

class AppMenuIcon extends StatelessWidget {
  const AppMenuIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Get.toNamed('/setting'),
      // child: Container(
      //   width: 32.w,
      //   height: 32.w,
      //   child: AppAssetImage.square('assets/images/home/app_menu.png', dimension: 32.w),
      // ),
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset.zero,
              blurRadius: 10.r,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(width: 1.w, color: Colors.white),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4.h),
                blurRadius: 4.r,
                spreadRadius: 0,
                color: Color(0xffF4F9FE),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: SizedBox(
            width: 24.w,
            height: 24.w,
            child: AppAssetImage.square('assets/images/home/app_menu_1.png', dimension: 24.w),
          ),
        ),
      ),
    );
    // 'assets/images/home/icon_menu.webp'
  }
}
