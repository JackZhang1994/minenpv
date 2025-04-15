import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:yunyou_desktop/controllers/base/app_getx_controller.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';
import 'package:yunyou_desktop/pages/mine/personal/controllers/personal_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';
import 'package:yunyou_desktop/widgets/public/app_dialog.dart';

class AppDeviceManagementView extends StatelessWidget {
  const AppDeviceManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    final PersonalController t = PersonalController.to;
    return Skeletonizer(
      enabled: t.loadStatus == LoadStatus.load,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '设备管理',
              style: AppThemes.of().regular18text1,
            ),
            AppGaps.h16,
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _DeviceCardWidget(
                        deviceName: 'iPhone',
                        id: '0a45455734abd130',
                        enable: true,
                      ),
                    ),
                    AppGaps.w12,
                    Expanded(
                      child: _DeviceCardWidget(
                        deviceName: 'iPhone',
                        id: '123456',
                        enable: true,
                      ),
                    ),
                  ],
                ),
                AppGaps.h12,
                Row(
                  children: [
                    Expanded(
                      child: _DeviceCardWidget(enable: false),
                    ),
                    AppGaps.w12,
                    Expanded(
                      child: _DeviceCardWidget(enable: false),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DeviceCardWidget extends StatelessWidget {
  const _DeviceCardWidget({this.deviceName, this.id, required this.enable});

  final String? deviceName;
  final String? id;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    final AppUserController s = AppUserController.to;
    final PersonalController t = PersonalController.to;
    final bool isCurDevice = s.deviceId == id;
    return Container(
      constraints: BoxConstraints(minHeight: 116.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppAssetImage.square(
                  enable ? 'assets/images/mine/app_device.png' : 'assets/images/mine/app_device_locked.png',
                  dimension: 40.w,
                ),
                AppGaps.h12,
                Visibility(
                  visible: enable,
                  replacement: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '未解锁',
                        style: AppThemes.of().regular14text3,
                      ),
                      Text(
                        '',
                        style: AppThemes.of().regular14text3,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isCurDevice ? '本机设备' : (deviceName ?? ''),
                        style: AppThemes.of().regular14text1,
                      ),
                      AutoSizeText(
                        'ID: ${id ?? ''}',
                        style: AppThemes.of().regular14text1,
                        minFontSize: 10,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Visibility(
              visible: !isCurDevice && enable,
              child: GestureDetector(
                onTap: () {
                  Get.dialog(
                    AppDialog(
                      title: '确定移除该设备？',
                      negativeBtnText: '取消',
                      positiveBtnText: '确定',
                      onPositiveTap: () {
                        t.removeDevice(id ?? '');
                      },
                    ),
                  );
                },
                child: Text(
                  '移除',
                  style: AppThemes.of().regular12primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
