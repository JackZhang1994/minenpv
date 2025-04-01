#include "flutter_v2ray_desktop_plugin.h"

#include <windows.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

namespace flutter_v2ray_desktop {

// Function to get the architecture of the system
std::string GetArchitecture() {
#if defined(_M_X64)
  return "64";
#elif defined(_M_IX86)
  return "32";
#elif defined(_M_ARM64)
  return "arm64";
#elif defined(_M_ARM)
  return "arm32";
#else
  return "unknown";
#endif
}

// static
void FlutterV2rayDesktopPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "flutter_v2ray_desktop",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<FlutterV2rayDesktopPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

FlutterV2rayDesktopPlugin::FlutterV2rayDesktopPlugin() {}

FlutterV2rayDesktopPlugin::~FlutterV2rayDesktopPlugin() {}

void FlutterV2rayDesktopPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("getXRayPath") == 0) {
    // Get the architecture
    std::string arch = GetArchitecture();
    // Construct the resource folder path based on the architecture
    std::string resource_path = "resources/" + arch; // Adjust this according to your actual folder structure
    // Return the resource folder path
    result->Success(flutter::EncodableValue(resource_path));
  } else {
    result->NotImplemented();
  }
}

}  // namespace flutter_v2ray_desktop
