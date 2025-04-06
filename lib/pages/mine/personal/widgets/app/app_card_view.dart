import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

class AppCardView extends StatelessWidget {
  const AppCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppUserController.to;
    return Row(
      children: [
        Obx(
          () => _CardView(
            label: '会员等级',
            value: s.isVip
                ? s.vipType == 1
                    ? '钻石会员'
                    : '青铜会员'
                : '未开通',
            imgPath: 'assets/images/mine/app_vip_level.webp',
            onTap: () {},
          ),
        ),
        Container(
          width: 1.w,
          height: 74.h,
          color: AppThemes.of().colors.dividerColor,
        ),
        Obx(
          () => _CardView(
            label: '到期时间',
            value: '${s.daysLeft} 天',
            imgPath: 'assets/images/mine/app_days_left.webp',
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class _CardView extends StatelessWidget {
  const _CardView({
    required this.label,
    required this.value,
    required this.imgPath,
    required this.onTap,
  });

  final String label;
  final String value;
  final String imgPath;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 74.h,
        child: Row(
          children: [
            AppGaps.w24,
            AppAssetImage.square(imgPath, dimension: 34.w),
            AppGaps.w12,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppThemes.of().regular12text3,
                  ),
                  RichText(
                    text: TextSpan(text: value, style: AppThemes.of().regular14primary, children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: AppAssetImage.square(
                          'assets/images/public/app_arrow_right_primary.webp',
                          dimension: 20.w,
                        ),
                      ),
                    ]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
