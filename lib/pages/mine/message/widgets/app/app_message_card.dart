import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/mine/message/models/message_model.dart';
import 'package:yunyou_desktop/themes/index.dart';

class AppMessageCard extends StatelessWidget {
  const AppMessageCard({super.key, required this.entity});

  final MessageEntity entity;

  @override
  Widget build(BuildContext context) {
    return RcGestureDetector(
      onTap: () {
        Get.toNamed('/message_detail', arguments: {'entity': entity});
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            entity.formatMessageTime,
            style: AppThemes.of().regular14text3,
          ),
          AppGaps.h12,
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entity.noticeTitle,
                  style: AppThemes.of().medium16text1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AppGaps.h4,
                Text(
                  entity.normalContent,
                  style: AppThemes.of().medium14text3,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
