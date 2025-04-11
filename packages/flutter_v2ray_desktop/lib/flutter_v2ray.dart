import 'dart:io';

import 'flutter_v2ray_desktop.dart';

class FlutterV2ray {
  final void Function(String log) logListner;
  final void Function(V2rayStatus status) statusListner;
  FlutterV2ray({required this.logListner, required this.statusListner});
  Future<void> startV2Ray({
    required String config,
    ConnectionType connectionType = ConnectionType.systemProxy,
  }) async {
    if(Platform.isIOS){

    } else{

    }

  }
}