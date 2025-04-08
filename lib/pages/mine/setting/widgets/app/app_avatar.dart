import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

class AppAvatar extends GetView<AppUserController> {
  const AppAvatar({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Obx(
        () => AppAssetImage.square(
          controller.isLogin ? 'assets/images/mine/app_avatar.png' : 'assets/images/mine/app_avatar_grey.png',
          dimension: size,
        ),
      ),
    );
  }
}
