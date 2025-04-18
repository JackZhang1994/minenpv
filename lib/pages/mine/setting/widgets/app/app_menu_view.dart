import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/mine/setting/controllers/setting_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

class AppMenuView extends StatelessWidget {
  const AppMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    SettingController s = SettingController.to;
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final entity = s.menuList[index];
        return RcInkWell(
          onTap: entity.onTap,
          child: Container(
            width: 1.sw,
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              children: [
                AppAssetImage.square(
                  entity.imgPath,
                  dimension: 24.w,
                ),
                AppGaps.w12,
                Expanded(
                  child: Text(
                    entity.title,
                    style: AppThemes.of().medium16text1,
                    maxLines: 1,
                  ),
                ),
                AppAssetImage.square(
                  'assets/images/public/app_arrow_right_grey.png',
                  dimension: 20.w,
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Divider(),
        );
      },
      itemCount: s.menuList.length,
    );
  }
}
