import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';
import 'package:yunyou_desktop/widgets/public/app_dialog.dart';

class VipTitleView extends StatelessWidget {
  const VipTitleView({super.key, required this.vipType});

  final int vipType;

  @override
  Widget build(BuildContext context) {
    final bool isSvip = vipType == 2;
    return Container(
      width: double.infinity,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(right: 8.w),
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
          RcGestureDetector(
            onTap: () {
              final String title = isSvip ? '钻石会员' : '青铜会员';
              final String content =
                  isSvip ? '既可以自动匹配最快线路，也能自主选择国家线路；可随意切换安全模式和极速模式。' : '自动匹配最快线路，支持极速模式，自由访问外网时又不影响国内网站的访问速度。';
              Get.dialog(
                AppDialog(
                  title: title,
                  content: content,
                  positiveBtnText: '知道了',
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: AppAssetImage.square(
                isSvip ? 'assets/images/funds/app_svip_intro.png' : 'assets/images/funds/app_vip_intro.png',
                dimension: 16.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
