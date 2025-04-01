#ifndef FLUTTER_PLUGIN_FLUTTER_V2RAY_DESKTOP_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_V2RAY_DESKTOP_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_v2ray_desktop {

class FlutterV2rayDesktopPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterV2rayDesktopPlugin();

  virtual ~FlutterV2rayDesktopPlugin();

  // Disallow copy and assign.
  FlutterV2rayDesktopPlugin(const FlutterV2rayDesktopPlugin&) = delete;
  FlutterV2rayDesktopPlugin& operator=(const FlutterV2rayDesktopPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_v2ray_desktop

#endif  // FLUTTER_PLUGIN_FLUTTER_V2RAY_DESKTOP_PLUGIN_H_
