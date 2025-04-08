import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'ex_permission_utils.dart';

class ScreenshotController extends GetxController {
  final GlobalKey screenKey = GlobalKey();

  var _requesting = false;

  bool get isRequestingScreenshot => _requesting;

  Completer? _completer;

  /// 通知截屏逻辑可以截屏了
  void notifyCanTakeScreenshot() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _lastTimer?.cancel();
      _completer?.complete();
      _completer = null;
      _requesting = false;
    });
  }

  Timer? _lastTimer;

  ///通知子组件，我准备截屏了
  Future? _askScreenshot() {
    _requesting = true;

    //取消上次的操作
    _lastTimer?.cancel();
    _completer?.complete();
    _completer = Completer();

    //超时逻辑
    _lastTimer = Timer(const Duration(milliseconds: 400), () {
      _completer?.complete();
      _completer = null;
    });
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      update();
    });
    return _completer?.future;
  }

  void _finishTakeScreenshot() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      update();
    });
  }

  double? _ratio;

  void setRatio(double ratio) {
    _ratio = ratio;
  }

  /// 截取widget
  Future<Uint8List?> _screenshot() async {
    //等待子组件准备完成
    await _askScreenshot();
    try {
      RenderRepaintBoundary boundary = screenKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: _ratio ?? 1);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      debugPrint("截屏报错： --- $e");
    }
    _finishTakeScreenshot();
    return null;
  }

  /// 保存图片
  Future savePhoto({ValueChanged? saveResult}) async {
    _screenshot().then((value) async {
      if (value == null) {
        saveResult?.call(false);
        return;
      }
      PermissionStatus? status = await ExPermissionUtils.getRelatePermissionStatus(ExPermissionStyle.permission_Photos);
      if ((status != null && status.isGranted) || Platform.isIOS && status != null && status.isLimited) {
        var result = await ImageGallerySaverPlus.saveImage(
          value,
          quality: 100,
        );
        saveResult?.call(result != null);
      } else {
        saveResult?.call(false);
      }
    });
  }

  /// 保存截取的图片到临时文件
  Future<File?> captureImage() async {
    return _screenshot().then((value) async {
      if (value == null) {
        return null;
      }
      Directory applicationDir = await getTemporaryDirectory();
      bool isDirExist = await Directory(applicationDir.path).exists();
      if (!isDirExist) Directory(applicationDir.path).create();
      File saveFile =
          await File("${applicationDir.path}${DateTime.now().millisecondsSinceEpoch}.jpg").writeAsBytes(value);
      debugPrint(saveFile.path);
      return saveFile;
    });
  }
}
