import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'flutter_v2ray_desktop_method_channel.dart';

abstract class FlutterV2rayDesktopPlatform extends PlatformInterface {
  /// Constructs a FlutterV2rayDesktopPlatform.
  FlutterV2rayDesktopPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterV2rayDesktopPlatform _instance =
      MethodChannelFlutterV2rayDesktop();

  /// The default instance of [FlutterV2rayDesktopPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterV2rayDesktop].
  static FlutterV2rayDesktopPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterV2rayDesktopPlatform] when
  /// they register themselves.
  static set instance(FlutterV2rayDesktopPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getXRayPath() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
