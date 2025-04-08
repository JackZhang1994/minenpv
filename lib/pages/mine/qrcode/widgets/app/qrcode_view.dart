import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/configs/index.dart';
import 'package:yunyou_desktop/themes/index.dart';

import '../../controllers/qrcode_controller.dart';
import '../../screenshoot/share_screenshot_view.dart';

class QrcodeView extends GetView<QrcodeController> {
  const QrcodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShareScreenshotView(
          isManualSavePicture: true,
          ratio: MediaQuery.of(context).devicePixelRatio,
          child: Container(
            width: 194.w,
            height: 194.w,
            padding: EdgeInsets.all(8.w),
            color: Colors.white,
            child: PrettyQrView.data(
              data: 'https://www.baidu.com',
              errorCorrectLevel: QrErrorCorrectLevel.Q,
            ),
          ),
        ),
        AppGaps.h20,
        Text(
          '保存二维码，永不失联',
          style: AppThemes.of().medium18text1,
        ),
        AppGaps.h8,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            '永远摆脱封锁、永远拥有互联网自由，建议您珍藏${AppConfigs.appDisplayName} VPN 防丢失二维码到相册!',
            style: AppThemes.of().medium14text3.copyWith(color: Color(0xff666666)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
