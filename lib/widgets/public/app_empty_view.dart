import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

class AppEmptyBtnItemBean {
  final IconData? iconFont;
  final String? title; //标题
  final VoidCallback? callback;

  AppEmptyBtnItemBean({this.iconFont, this.title, this.callback});
}

class AppEmptyView extends StatelessWidget {
  final String? title;
  final String? detail;
  final AppEmptyBtnItemBean? leadingBean;
  final AppEmptyBtnItemBean? trailingBean;

  AppEmptyView({
    Key? key,
    this.title,
    this.detail,
    this.leadingBean,
    this.trailingBean,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppAssetImage.square(
            'assets/images/public/icon_empty_bg.webp',
            dimension: 96.w,
          ),
          if ((title ?? '').isNotEmpty)
            Text(
              title ?? '',
              style: AppThemes.of().medium16text1,
              textAlign: TextAlign.center,
            ),
          if ((detail ?? '').isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                detail ?? '',
                textAlign: TextAlign.center,
                style: AppThemes.of().regular14text3,
              ),
            ),
        ],
      ),
    );
  }
}
