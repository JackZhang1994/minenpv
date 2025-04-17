/*
* @overview: 基础控制器
* @Author: rcc 
* @Date: 2024-06-08 09:17:46 
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';

enum LoadStatus {
  load,
  error,
  success,
}

class AppGetxController extends GetxController {
  CancelToken cancelToken = CancelToken();

  /// 点击状态
  final RxBool _clickStatus = true.obs;

  /// 加载状态
  final Rx<LoadStatus> _loadStatus = Rx(LoadStatus.load);

  /// 可以点击
  bool get isClick => _clickStatus.value;

  /// 不可以点击
  bool get isNotClick => !_clickStatus.value;

  /// 组件加载状态
  LoadStatus get loadStatus => _loadStatus.value;

  /// 组件加载成功
  bool get isLoadSuccess => loadStatus == LoadStatus.success;

  /// 组件加载未成功
  bool get isNotLoadSuccess => loadStatus != LoadStatus.success;

  /// 切换点击状态
  void switchClickStatus(bool status) => _clickStatus.value = status;

  /// 切换加载类型状态
  void switchLoadStatus(LoadStatus status) => _loadStatus.value = status;

  /// 关闭键盘
  void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  @mustCallSuper
  @override
  void onClose() {
    cancelToken.cancel();
    super.onClose();
  }
}

class AppSuperGetxController extends SuperController {
  CancelToken cancelToken = CancelToken();

  /// 点击状态
  final RxBool _clickStatus = true.obs;

  /// 加载状态
  final Rx<LoadStatus> _loadStatus = Rx(LoadStatus.load);

  /// 可以点击
  bool get isClick => _clickStatus.value;

  /// 不可以点击
  bool get isNotClick => !_clickStatus.value;

  /// 组件加载状态
  LoadStatus get loadStatus => _loadStatus.value;

  /// 组件加载成功
  bool get isLoadSuccess => loadStatus == LoadStatus.success;

  /// 组件加载未成功
  bool get isNotLoadSuccess => loadStatus != LoadStatus.success;

  /// 切换点击状态
  void switchClickStatus(bool status) => _clickStatus.value = status;

  /// 切换加载类型状态
  void switchLoadStatus(LoadStatus status) => _loadStatus.value = status;

  /// 关闭键盘
  void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  @mustCallSuper
  @override
  void onClose() {
    cancelToken.cancel();
    super.onClose();
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
