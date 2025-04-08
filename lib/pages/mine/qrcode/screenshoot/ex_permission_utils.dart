import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yunyou_desktop/widgets/public/app_dialog.dart';

import 'device_utils.dart';

enum ExPermissionStyle {
  ///照相机
  permission_Camera,

  ///位置
  permission_Location,

  //麦克风
  permission_Mic,

  ///iOS相册权限 Android 存储权限
  permission_Photos,
}

class ExPermissionUtils {
  ///只获取权限状态,不尝试申请系统权限
  static Future<PermissionStatus> onlyGetRelatePermissionStatus(ExPermissionStyle permissionName) async {
    PermissionStatus status;
    switch (permissionName) {
      case ExPermissionStyle.permission_Camera:
        status = await Permission.camera.status;
        break;
      case ExPermissionStyle.permission_Location:
        status = await Permission.location.status;
        break;
      case ExPermissionStyle.permission_Mic:
        status = await Permission.microphone.status;
        break;
      case ExPermissionStyle.permission_Photos:
        if (Platform.isAndroid) {
          int version = Device.getAndroidSdkInt();
          if (version <= 32) {
            status = await Permission.storage.status;
          } else {
            status = await Permission.photos.status;
          }
        } else {
          status = await Permission.photos.status;
        }
        break;
      default:
        {
          status = PermissionStatus.denied;
          debugPrint('权限未找到');
        }
    }
    return status;
  }

  /// 获取权限状态，未授权时会尝试获取系统权限
  /// permissionName 要获取的权限名称
  static Future<PermissionStatus?> getRelatePermissionStatus(ExPermissionStyle permissionName) async {
    PermissionStatus? status = await _requestPermission(permissionName);
    return status;
  }

  static Future<PermissionStatus?> _requestPermission(ExPermissionStyle permissionName) async {
    PermissionStatus? status = await onlyGetRelatePermissionStatus(permissionName);
    //获取当前的权限

    if (status == PermissionStatus.granted || (Platform.isIOS && status != null && status.isLimited)) {
      //已经授权
      debugPrint('$permissionName' '权限授权');
    } else {
      debugPrint('$permissionName' '权限未授权');
      status = await _requestSystemPermission(permissionName);
      if (status == PermissionStatus.granted || (Platform.isIOS && status != null && status.isLimited)) {
        debugPrint('$permissionName' '权限尝试申请成功');
      } else {
        Future.delayed(const Duration(microseconds: 100), () {
          showDialog(permissionStyle: permissionName);
        });

        debugPrint('$permissionName' '权限尝试申请失败');
      }
    }

    return status;
  }

  static Future<PermissionStatus?> _requestSystemPermission(ExPermissionStyle permissionName) async {
    PermissionStatus? status;

    ///发起一次权限申请
    switch (permissionName) {
      case ExPermissionStyle.permission_Camera:
        status = await Permission.camera.request();
        break;
      case ExPermissionStyle.permission_Location:
        status = await Permission.location.request();
        break;
      case ExPermissionStyle.permission_Mic:
        status = await Permission.microphone.request();
        break;
      case ExPermissionStyle.permission_Photos:
        if (Platform.isAndroid) {
          int version = Device.getAndroidSdkInt();
          if (version <= 32) {
            status = await Permission.storage.request();
          } else {
            status = await Permission.photos.request();
          }
        } else {
          status = await Permission.photos.request();
        }
        break;
      default:
        break;
    }
    return status;
  }

  static void showDialog({ExPermissionStyle? permissionStyle}) {
    Get.dialog(AppDialog(
      title: '温馨提示',
      content: dialogContent(permissionStyle: permissionStyle),
      negativeBtnText: '我知道了',
      positiveBtnText: '去设置',
      onPositiveTap: () {
        openAppSettings();
      },
    ));
  }

  static String dialogContent({required ExPermissionStyle? permissionStyle}) {
    String content = '';
    if (permissionStyle == null) {
      return content;
    }
    switch (permissionStyle) {
      case ExPermissionStyle.permission_Camera:
        content = '没有获取到您的相机权限，点击去设置！';
        break;
      case ExPermissionStyle.permission_Location:
        content = '没有获取到您的定位权限，点击去设置！';
        break;
      case ExPermissionStyle.permission_Mic:
        content = '没有获取到您的麦克风权限，点击去设置！';
        break;
      case ExPermissionStyle.permission_Photos:
        content = '没有获取到您的相册权限，点击去设置！';
        break;
      default:
    }
    return content;
  }
}
