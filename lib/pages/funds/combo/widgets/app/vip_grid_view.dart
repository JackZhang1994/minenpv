import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

import '../../controllers/acombo_controller.dart';
import '../../models/combo_model.dart';

class VipGridView extends StatelessWidget {
  const VipGridView({super.key, required this.vipType});

  final int vipType;

  @override
  Widget build(BuildContext context) {
    final s = ComboController.to;
    final bool isSvip = vipType == 2;
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: isSvip ? s.combo2.length : s.combo1.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 11.h,
        crossAxisSpacing: 11.w,
        childAspectRatio: 154.w / 92.h,
      ),
      itemBuilder: (_, int index) {
        final Shop entity = isSvip ? s.combo2[index] : s.combo1[index];
        return _CardView(entity);
      },
    );
  }
}

class _CardView extends StatelessWidget {
  const _CardView(this.data);

  final Shop data;

  @override
  Widget build(BuildContext context) {
    final ComboController s = ComboController.to;
    final bool isSvip = data.vipType == 2;
    final Color color = isSvip ? Color(0xff7B5325) : Color(0xff3B479C);
    final String assetFlagPath =
        isSvip ? 'assets/images/funds/app_svip_flag.png' : 'assets/images/funds/app_vip_flag.png';
    return RcGestureDetector(
      onTap: () => s.placeOrder(data),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(width: 1.w, color: color),
            ),
            padding: EdgeInsets.symmetric(vertical: 12.h),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  s.convertDaysToDuration(data.vipDuration ?? 0),
                  style: AppThemes.of().medium16text1.copyWith(height: 1),
                ),
                AppGaps.h6,
                Text(
                  'USD ${data.price}',
                  style: AppThemes.of().semibold16text1.copyWith(color: color, height: 1),
                ),
                AppGaps.h6,
                Text(
                  '折合USD ${s.calcDailyPrice(data.price ?? 0, data.vipDuration ?? 0)}/天',
                  style: AppThemes.of().semibold10text1.copyWith(color: color, height: 1),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0.8.w,
            top: 0.8.w,
            child: Visibility(
              visible: data.price != null &&
                  data.oldPrice != null &&
                  data.price != 0 &&
                  data.oldPrice != 0 &&
                  data.price != data.oldPrice,
              child: AppAssetImage.square(assetFlagPath, dimension: 50.w),
            ),
          ),
          Positioned(
            left: 0.8.w,
            top: 0.8.w,
            child: Visibility(
              visible: data.price != null &&
                  data.oldPrice != null &&
                  data.price != 0 &&
                  data.oldPrice != 0 &&
                  data.price != data.oldPrice,
              child: AppAssetImage.square(assetFlagPath, dimension: 50.w),
            ),
          ),
          Positioned(
            top: 20.w,
            left: -18.w,
            child: Visibility(
              visible: data.price != null &&
                  data.oldPrice != null &&
                  data.price != 0 &&
                  data.oldPrice != 0 &&
                  data.price != data.oldPrice,
              child: Transform(
                transform: Matrix4.rotationZ(315 * pi / 180),
                child: SizedBox(
                  width: 50.w,
                  height: 50.w,
                  child: Center(
                    child: Text(
                      s.calcDiscountValue(data.price ?? 0, data.oldPrice ?? 0, data.vipDuration ?? 0),
                      style: AppThemes.of().semibold12text3.copyWith(color: color),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
