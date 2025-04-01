import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_v2ray_desktop_platform_interface.dart';

/// An implementation of [FlutterV2rayDesktopPlatform] that uses method channels.
class MethodChannelFlutterV2rayDesktop extends FlutterV2rayDesktopPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_v2ray_desktop');

  @override
  Future<String?> getXRayPath() async {
    final version = await methodChannel.invokeMethod<String>('getXRayPath');
    return version;
  }
}
