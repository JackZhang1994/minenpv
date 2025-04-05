import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/configs/index.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';
import 'package:yunyou_desktop/widgets/public/app_image.dart';

class AppPersonalInfoView extends StatelessWidget {
  const AppPersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppUserController.to;
    return GestureDetector(
      onTap: () {
        Get.toNamed('/personal');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
        child: Row(
          children: [
            Stack(
              children: [
                Obx(
                  () => AppImage(
                    url: AppConfigs.buildImageUrl(s.user.email.toString()),
                    width: 68.w,
                    height: 68.w,
                    borderRadius: 34.w,
                    placeholder: AppAssetImage.square('assets/images/mine/app_default_avatar.webp', dimension: 68.w),
                    errorWidget: AppAssetImage.square('assets/images/mine/app_default_avatar.webp', dimension: 68.w),
                  ),
                ),
                Positioned(
                  left: -1.5.w,
                  right: -1.5.w,
                  bottom: -9.w,
                  child: Obx(
                    () => AppAssetImage(
                      s.isVip
                          ? s.vipType == 1
                              ? 'assets/images/mine/app_svip.webp'
                              : 'assets/images/mine/app_vip.webp'
                          : 'assets/images/mine/app_no_vip.webp',
                      width: 73.w,
                      height: 27.w,
                    ),
                  ),
                ),
              ],
            ),
            AppGaps.w12,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      s.email,
                      style: AppThemes.of().medium18text1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AppGaps.h6,
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'ID:'),
                        WidgetSpan(child: AppGaps.w8),
                        TextSpan(text: s.deviceId),
                        WidgetSpan(child: AppGaps.w14),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () async {
                              final result = await RcTools.copyText(s.uid);
                              RcToast(result ? '复制成功' : '复制失败');
                            },
                            child: Icon(
                              Icons.copy,
                              size: 16.sp,
                              color: AppThemes.of().colors.text3,
                            ),
                          ),
                        ),
                      ],
                      style: AppThemes.of().semibold14text3,
                    ),
                  ),
                  AppGaps.h6,
                  Obx(
                    () => RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: '到期时间:'),
                          WidgetSpan(child: AppGaps.w8),
                          TextSpan(text: s.endTimeShow),
                        ],
                        style: AppThemes.of().semibold12text3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // AppAssetImage.square(
            //   'assets/images/public/app_arrow_right.webp',
            //   dimension: 24.w,
            // ),
            Icon(
              Icons.arrow_forward_ios,
              size: 22.sp,
              color: AppThemes.of().colors.text3,
            ),
          ],
        ),
      ),
    );
  }
}
