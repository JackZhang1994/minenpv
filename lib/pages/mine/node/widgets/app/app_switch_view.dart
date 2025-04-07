import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/controllers/public/app_node_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

class AppSwitchView extends StatelessWidget {
  const AppSwitchView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppNodeController s = AppNodeController.to;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '模式选择',
            style: AppThemes.of().regular16text1,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              s.switchProxyMode(s.isProxyOnly.value);
            },
            child: SizedBox(
              width: 140.w,
              height: 30.w,
              child: Obx(
                () => Visibility(
                  visible: s.isProxyOnly.isFalse,
                  replacement: AppAssetImage(
                    'assets/images/mine/app_node_fast.png',
                    width: 140.w,
                    height: 30.w,
                  ),
                  child: AppAssetImage(
                    'assets/images/mine/app_node_safe.png',
                    width: 140.w,
                    height: 30.w,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
