import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

class AppAccountView extends StatelessWidget {
  const AppAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    AppUserController t = AppUserController.to;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Color(0xffF8F8F8),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppAssetImage.square(
            'assets/images/mine/app_avatar.png',
            dimension: 24.w,
          ),
          Text(
            t.email.toString(),
            style: AppThemes.of().medium16text1,
          ),
        ],
      ),
    );
  }
}
