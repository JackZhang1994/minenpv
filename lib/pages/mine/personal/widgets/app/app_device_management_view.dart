import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:yunyou_desktop/controllers/base/app_getx_controller.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';
import 'package:yunyou_desktop/pages/mine/personal/controllers/personal_controller.dart';
import 'package:yunyou_desktop/pages/mine/personal/models/device_list_model.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';
import 'package:yunyou_desktop/widgets/public/app_dialog.dart';

class AppDeviceManagementView extends StatelessWidget {
  const AppDeviceManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    final PersonalController t = PersonalController.to;
    return Obx(
      () {
        DeviceEntity? device1;
        DeviceEntity? device2;
        if (t.deviceList.length > 1) {
          device1 = t.deviceList[0];
          device2 = t.deviceList[1];
        } else if (t.deviceList.length == 1) {
          device1 = t.deviceList[0];
        }
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _DeviceCardWidget(
                            id: device1?.id,
                            deviceName: device1?.deviceName,
                            deviceId: device1?.deviceId,
                            enable: true,
                          ),
                        ),
                        AppGaps.w12,
                        Expanded(
                          child: _DeviceCardWidget(
                            id: device2?.id,
                            deviceName: device2?.deviceName,
                            deviceId: device2?.deviceId,
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
      },
    );
  }
}

class _DeviceCardWidget extends StatelessWidget {
  const _DeviceCardWidget({
    this.id,
    this.deviceName,
    this.deviceId,
    required this.enable,
  });

  final int? id;
  final String? deviceName;
  final String? deviceId;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    final AppUserController s = AppUserController.to;
    final PersonalController t = PersonalController.to;
    final bool isCurDevice = s.deviceId == deviceId;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (!enable) {
          Get.dialog(
            AppDialog(
              title: '设备未解锁',
              content: '一个账户目前最多仅支持两个设备，暂时不能解锁更多的设备，此功能会在后续版本推出，敬请期待！',
              positiveBtnText: '知道了',
            ),
          );
        } else {
          if (id == null) {
            Get.dialog(
              AppDialog(
                title: '设备可绑定',
                content: '当前账户还可绑定其他设备，只需在需绑定的设备中登录此账户，即可完成绑定。',
                positiveBtnText: '知道了',
              ),
            );
          }
        }
      },
      child: Container(
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
                    child: Visibility(
                      visible: id != null,
                      replacement: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '可绑定',
                            style: AppThemes.of().regular14primary,
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
                            'ID: ${id ?? 0}',
                            style: AppThemes.of().regular14text1,
                            minFontSize: 10,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Visibility(
                visible: !isCurDevice && enable && id != null,
                child: GestureDetector(
                  onTap: () {
                    Get.dialog(
                      AppDialog(
                        title: '确定移除该设备？',
                        negativeBtnText: '取消',
                        positiveBtnText: '确定',
                        onPositiveTap: () {
                          t.removeDevice(id ?? 0);
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
      ),
    );
  }
}
