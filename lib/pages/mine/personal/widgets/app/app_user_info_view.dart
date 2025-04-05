import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/mine/personal/widgets/app/app_card_view.dart';

import './app_personal_info_view.dart';

class AppUserInfoView extends StatelessWidget {
  const AppUserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 10.r,
            spreadRadius: 0,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        children: [
          AppPersonalInfoView(),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Divider(),
          ),
          AppCardView(),
        ],
      ),
    );
  }
}
