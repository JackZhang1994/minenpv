import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

class VipTitleView extends StatelessWidget {
  const VipTitleView({super.key, required this.vipType});

  final int vipType;

  @override
  Widget build(BuildContext context) {
    final bool isSvip = vipType == 2;
    return Container(
      width: double.infinity,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              isSvip ? 'assets/images/funds/app_svip_title_bg.png' : 'assets/images/funds/app_vip_title_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isSvip ? '钻石会员' : '青铜会员',
            style: AppThemes.of().medium18text1.copyWith(color: isSvip ? Color(0xff7B5325) : Color(0xff3B479C)),
          ),
          AppAssetImage.square(
            isSvip ? 'assets/images/funds/app_svip_intro.png' : 'assets/images/funds/app_vip_intro.png',
            dimension: 16.w,
          ),
        ],
      ),
    );
  }
}
