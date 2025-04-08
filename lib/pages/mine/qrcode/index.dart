import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/public/app_top_bar.dart';

import 'controllers/qrcode_controller.dart';
import 'screenshoot/share_screenshot_controller.dart';
import 'widgets/app/channel_view.dart';
import 'widgets/app/qrcode_button.dart';
import 'widgets/app/qrcode_view.dart';

class QrcodePage extends GetView<QrcodeController> {
  const QrcodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppThemes.of().colors.primaryColor.withOpacity(0.18),
              AppThemes.of().colors.primaryColor.withOpacity(0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppTopBar(
            title: '软件防丢失',
            backgroundColor: Colors.transparent,
            isMobile: true,
          ),
          body: SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppGaps.h32,
                  QrcodeView(),
                  AppGaps.h24,
                  QrcodeButton(),
                  const Spacer(),
                  ChannelView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QrcodePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<QrcodeController>(QrcodeController());
    Get.put<ScreenshotController>(ScreenshotController());
  }
}
