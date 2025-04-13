import 'package:flutter/material.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';

class IntercomUtils {
  const IntercomUtils._();

  static int? _curLoginedUid;

  static Future login() async {
    final AppUserController controller = AppUserController.to;
    final int? curUid = controller.isLogin ? controller.user.uid : null;
    final bool isUserLoggedIn = await Intercom.instance.isUserLoggedIn();
    if (isUserLoggedIn) {
      final Map<String, dynamic> map = await Intercom.instance.fetchLoggedInUserAttributes();
      final String userId = map['user_id'].toString();
      final int? userIdNum = int.tryParse(userId);
      if (curUid == userIdNum) {
        debugPrint('IntercomUtils ${curUid == null ? '游客已登录' : '用户$curUid已登录'}');
        _curLoginedUid = curUid;
        return Future.value(true);
      } else {
        await logout();
      }
    }
    _curLoginedUid = curUid;
    if (curUid != null) {
      debugPrint('IntercomUtils 用户$curUid开始登录');
      return await Intercom.instance.loginIdentifiedUser(userId: curUid.toString());
    } else {
      debugPrint('IntercomUtils 游客开始登录');
      return await Intercom.instance.loginUnidentifiedUser();
    }
  }

  static Future logout() async {
    debugPrint('IntercomUtils ${_curLoginedUid == null ? '游客开始登出' : '用户$_curLoginedUid开始登出'}');
    _curLoginedUid = null;
    return await Intercom.instance.logout();
  }

  static Future displayMessenger() async {
    debugPrint('IntercomUtils ${_curLoginedUid == null ? '游客进入客服' : '用户$_curLoginedUid进入客服'}');
    return Intercom.instance.displayMessenger();
  }
}
