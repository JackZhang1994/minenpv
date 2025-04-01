#include "include/flutter_v2ray_desktop/flutter_v2ray_desktop_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_v2ray_desktop_plugin.h"

void FlutterV2rayDesktopPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_v2ray_desktop::FlutterV2rayDesktopPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
