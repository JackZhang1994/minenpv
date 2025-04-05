import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/mine/app_setting/controllers/app_setting_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

class AppMenuView extends StatelessWidget {
  const AppMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettingController s = AppSettingController.to;
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
            height: 56.h,
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                )
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
