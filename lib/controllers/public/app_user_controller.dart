/*
* @overview: 全局-用户信息
* @Author: rcc 
* @Date: 2024-06-09 18:49:00 
*/

import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/utils/intercom_utils.dart';

import '/controllers/base/app_getx_controller.dart';
import '/models/user_model.dart';
import '../../configs/index.dart';
import '../../models/message_model.dart';

class AppUserController extends AppGetxController {
  static AppUserController get to => Get.find<AppUserController>();

  final RxBool loginStatus = false.obs;

  /// 域名
  final RxString baseUrl = AppConfigs.apiUrl.obs;

  final Rx<Data> _user = Data.init().obs;

  bool get isLogin => loginStatus.value;

  bool get isNotLogin => !isLogin;

  Data get user => _user.value;

  /// 最新公告
  // Ann get bulletin => _bulletin.value;

  /// 账户余额
  String get balance => 0.toString();

  /// 设备数量
  // int get device => user.nodeConnector;

  /// UID
  String get uid => user.uid?.toString() ?? '';

  /// 邮箱
  String get email => user.email?.toString() ?? '';

  /// 会员到期时间
  String get endTimeShow =>
      isVip ? DateFormat('yyyy-MM-dd HH:mm:ss').format(user.vipEndTime ?? DateTime.now()) : '1970-01-01 00:00:00';

  /// 是否会员
  bool get isVip => user.vipEndTime!.isAfter(DateTime.now());

  int get vipType => user.vipType ?? 0;

  /// 会员剩余天数
  int get daysLeft => user.vipEndTime!.difference(DateTime.now()).inDays;

  /// 设备ID
  late String deviceId;

  /// 设备平台
  late String platform;

  late Rx<Uri?> url = Uri(scheme: 'mailto', path: 'John.Doe@example.com', queryParameters: {'subject': 'Example'}).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    _onInit();
  }

  void _onInit() async {
    if (kDebugMode || kProfileMode) {
      print('获取vmurl');
      url.value = await getVmUri();
    }
    deviceId = await FlutterUdid.udid;
    print("devicedID:$deviceId");
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    } else if (Platform.isWindows) {
      platform = 'windows';
    } else if (Platform.isLinux) {
      platform = 'linux';
    } else if (Platform.isMacOS) {
      platform = 'macos';
    } else {
      platform = 'unknown';
    }
  }

  Future<Uri?> getVmUri() async {
    ServiceProtocolInfo serviceProtocolInfo = await Service.getInfo();
    return serviceProtocolInfo.serverUri;
  }

  /// 获取用户信息
  Future<void> getUser() async {
    const String url = '/api/user/info';

    final result = await RcHttp.get<UserModel>(
      url,
      cancelToken: cancelToken,
      errorJson: () => UserModel.init(),
      fromJson: (json) => UserModel.fromJson(json),
    );
    if (result.code == 200) {
      _user.value = result.data!;
    }
    loginStatus.value = result.code == 200;
    await IntercomUtils.login();
  }

  /// 发送短信验证码
  Future<bool> sendCode(email) async {
    const String url = '/api/public/sms_code';
    final Map<String, dynamic> data = {
      'email': email,
    };
    final result = await RcHttp.post<MessageModel>(
      url,
      data: data,
      cancelToken: cancelToken,
      errorJson: () => MessageModel.init(),
      fromJson: (json) => MessageModel.fromJson(json),
    );

    // print(result.toString());

    // await Future.delayed(Duration(seconds: 2));
    // var result = MessageModel(
    //   code: 200,
    //   msg: '',
    //   data: '',
    // );
    if (result.code == 200) {
      print('$email 验证码发送成功');
      return true;
    } else {
      return false;
    }
  }

  /// 重置用户状态
  Future<void> resetUser() async {
    loginStatus.value = false;
    _user.value = Data.init();

    await RcStorage.remove(RcStorageKey.token);
    await IntercomUtils.logout();
    await IntercomUtils.login();
  }

  /// 存储token
  Future<void> setToken(String token) async {
    await RcStorage.setString(RcStorageKey.token, token);
  }
}
