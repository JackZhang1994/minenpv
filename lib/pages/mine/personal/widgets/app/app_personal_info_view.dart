import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/configs/index.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';
import 'package:yunyou_desktop/pages/mine/personal/controllers/personal_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';
import 'package:yunyou_desktop/widgets/public/app_image.dart';

class AppPersonalInfoView extends StatelessWidget {
  const AppPersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppUserController.to;
    final v = PersonalController.to;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                AppGaps.h12,
                Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => v.changePwdVisibility(),
                      child: Obx(
                        () {
                          String password = '123456';
                          if (v.pwdVisible.isFalse) {
                            password = '*' * password.length;
                          }
                          return RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: '密码:'),
                                WidgetSpan(child: AppGaps.w4),
                                TextSpan(text: password),
                                WidgetSpan(child: AppGaps.w4),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: AppAssetImage.square(
                                    v.pwdVisible.isTrue
                                        ? 'assets/images/public/app_eye_opened.png'
                                        : 'assets/images/public/app_eye_closed.png',
                                    dimension: 16.w,
                                  ),
                                ),
                              ],
                              style: AppThemes.of().regular14text3,
                            ),
                          );
                        },
                      ),
                    ),
                    AppGaps.w24,
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          // TODO 修改密码
                        },
                        child: Text(
                          '修改密码',
                          style: AppThemes.of().regular12primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
