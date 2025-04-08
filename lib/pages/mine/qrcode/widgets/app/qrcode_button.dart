import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yunyou_desktop/pages/mine/qrcode/controllers/qrcode_controller.dart';
import 'package:yunyou_desktop/widgets/public/app_button.dart';

class QrcodeButton extends GetView<QrcodeController> {
  const QrcodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: '保存到相册',
      onTap: () {
        controller.saveImage();
      },
    );
  }
}
