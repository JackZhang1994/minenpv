import 'dart:async';
import 'dart:convert';
export 'v2ray_parser.dart';

import 'package:flutter_v2ray/flutter_v2ray.dart';

import 'flutter_v2ray_desktop_platform_interface.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

enum DelayType { http, icmp, tcp }

enum ConnectionType { proxy, systemProxy, vpn }

enum ConnectionState { connected, disconnected }

class V2rayStatus {
  final Duration duration;
  final ConnectionState state;
  final int download;
  final int upload;
  final int totalDownload;
  final int totalUpload;

  const V2rayStatus({
    this.duration = const Duration(),
    this.state = ConnectionState.disconnected,
    this.download = 0,
    this.upload = 0,
    this.totalDownload = 0,
    this.totalUpload = 0,
  });

  @override
  String toString() {
    return 'V2rayStatus(duration: $duration, state: $state, download: $download, upload: $upload, totalDownload: $totalDownload, totalUpload: $totalUpload)';
  }
}

class FlutterV2rayDesktop with AndroidV2ray{
  final void Function(String log) logListner;
  final void Function(V2rayStatus status) statusListner;
  Process? _xray;
  Process? _tun2socks;
  Timer? _statusTimer;
  ConnectionType _connectionType = ConnectionType.systemProxy;
  final _routeAddresses = [
    "1.0.0.0/8",
    "2.0.0.0/7",
    "4.0.0.0/6",
    "8.0.0.0/5",
    "16.0.0.0/4",
    "32.0.0.0/3",
    "64.0.0.0/2",
    "128.0.0.0/1",
    "198.18.0.0/15",
  ];

  FlutterV2rayDesktop({required this.logListner, required this.statusListner});

  Future<String?> _getXRayPath() async {
    if (Platform.isMacOS) {
      return await FlutterV2rayDesktopPlatform.instance.getXRayPath();
    }
    return File(Platform.resolvedExecutable).parent.path;
  }

  Future<void> _runXRay(String config) async {
    if (_xray != null) {
      return;
    }
    final xpath = await _getXRayPath();
    if (xpath == null) return;
    final configPath = path.join(xpath, 'config.json');
    await File(configPath).writeAsString(config);


    final xrayPath = path.join(xpath, 'xray');
    if(Platform.isMacOS) {
      final xrayFile = File(xrayPath);
      if (!await xrayFile.exists()) {
        throw Exception("xray 文件不存在: $xrayPath");
      }
      final chmodResult = await Process.run('chmod', ['+x', xrayPath]);
      if (chmodResult.exitCode != 0) {
        // 如果赋予权限失败，抛出异常
        throw Exception("无法为 xray 赋予执行权限: ${chmodResult.stderr}");
      }
    }

    _xray = await Process.start(
      path.join(xpath, 'xray'),
      ['run', '-c', path.join(xpath, 'config.json'), '--disable-color'],
    );

    _xray!.stdout.listen((event) {
      logListner.call("[sing-box] ${utf8.decode(event)}");
    });
    _xray!.stderr.listen((event) {
      logListner.call("[sing-box] ${utf8.decode(event)}");
    });
  }

  void _stopXRay() {
    if (_xray == null) {
      return;
    }
    _xray!.kill();
    _xray = null;
  }

  Future<void> _runTun2Socks(String proxy) async {
    if (_tun2socks != null) {
      return;
    }

    if (proxy.isNotEmpty && proxy.startsWith("socks") && proxy[5] != '5') {
      proxy = "socks5${proxy.substring(5)}";
    }
    final xpath = await _getXRayPath();
    if (xpath == null) return;
    final device = Platform.isWindows ? "wintun" : "utun124";
    // final interface = Platform.isWindows ? "Wi-Fi" : "en0";
    final interface = (await NetworkInterface.list()).first.name;

    _tun2socks = await Process.start(
      path.join(xpath, 'tun2socks'),
      [
        '-device',
        device,
        "-proxy",
        proxy,
        "-interface",
        interface,
      ],
    );

    _tun2socks!.stdout.listen((event) {
      logListner.call("[tun2socks] ${utf8.decode(event)}");
    });
    _tun2socks!.stderr.listen((event) {
      logListner.call("[tun2socks] ${utf8.decode(event)}");
    });
  }

  void _stopTun2socks() {
    if (_tun2socks == null) {
      return;
    }
    _tun2socks!.kill();
    _tun2socks = null;
  }

  _startStatusTimer() async {
    final xpath = await _getXRayPath();
    if (xpath == null) return;
    final readerPath = path.join(xpath, "v2ray-stats-reader");

    if(Platform.isMacOS) {
      final readerFile = File(readerPath);
      if (!await readerFile.exists()) {
        throw Exception("v2ray-stats-reader 文件不存在: $readerPath");
      }

      final chmodResult = await Process.run('chmod', ['+x', readerPath]);
      if (chmodResult.exitCode != 0) {
        throw Exception(
            "无法为 v2ray-stats-reader 赋予执行权限: ${chmodResult.stderr}");
      }
    }

    int previusDown = 0;
    int previusUp = 0;
    await Future.delayed(const Duration(seconds: 1));
    _statusTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final result =
      await Process.run(readerPath, ["-e", "127.0.0.1:18194", "-t", "3"]);
      final resultList = result.stderr.trim().split("\n");

      late int upload, download, duration;
      try {
        duration = int.parse(resultList.last.split(" ").last);
      } catch (e) {
        print("Error parsing duration: $e");
        duration = 0; // 处理 parse 错误，设置默认值
      }

      if (resultList.length >= 3) {
        upload = int.parse(resultList[0].split(" ").last);
        download = int.parse(resultList[1].split(" ").last);
      } else {
        upload = 0;
        download = 0;
      }
      statusListner.call(V2rayStatus(
        upload: upload - previusUp,
        state: ConnectionState.connected,
        download: download - previusDown,
        totalUpload: upload,
        totalDownload: download,
        duration: Duration(seconds: duration),
      ));
      previusUp = upload;
      previusDown = download;
    });
  }

  Future<String> _validateConfig(String config) async {
    // final json = jsonDecode(config);
    // if (!["socks", "http", "https"].contains(json["inbounds"][0]["protocol"])) {
    //   throw 'Protocol is not valid.';
    // }
    // return '${json["inbounds"][0]["protocol"]}://${json["inbounds"][0]["listen"]}:${json["inbounds"][0]["port"]}';
    return 'socks://127.0.0.1:10315';
  }

  Future<void> _setDarwinSystemProxy(String proxy) async {
    if (proxy.isEmpty) {
      await Process.run(
          "networksetup", ["-setsocksfirewallproxystate", "wi-fi", "off"]);
      await Process.run("networksetup", ["-setwebproxystate", "wi-fi", "off"]);
      return;
    }
    final uri = Uri.tryParse(proxy);
    if (uri == null) {
      throw 'inbound proxy is not valid.';
    }
    await Process.run("networksetup",
        ["-setwebproxy", "wi-fi", uri.host, uri.port.toString()]);
    await Process.run("networksetup",
        ["-setsocksfirewallproxy", "wi-fi", uri.host, uri.port.toString()]);
  }

  Future<void> _setWindowsSystemProxy(String proxy) async {
    await Process.run('reg', [
      'add',
      r'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings',
      '/v',
      'ProxyEnable',
      '/t',
      'REG_DWORD',
      '/d',
      proxy.isEmpty ? '0' : '1',
      '/f',
    ]);
    if (proxy.isNotEmpty) {
      await Process.run('reg', [
        'add',
        r'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings',
        '/v',
        'ProxyServer',
        '/t',
        'REG_SZ',
        '/d',
        proxy,
        '/f',
      ]);
      await Process.run('netsh', [
        'winhttp',
        'set',
        'proxy',
        'proxy-server="$proxy"',
        'bypass-list="*.local;<local>"'
      ]);
    } else {
      await Process.run('netsh', [
        'winhttp',
        'reset',
        'proxy',
      ]);
    }
    // await Process.run('setx', ['http_proxy', proxy]);
    // await Process.run('setx', ['https_proxy', proxy]);
    await Process.run('powershell', [
      '-Command',
      '[System.Environment]::SetEnvironmentVariable("http_proxy","$proxy")'
    ]);
    await Process.run('powershell', [
      '-Command',
      '[System.Environment]::SetEnvironmentVariable("https_proxy","$proxy")'
    ]);
  }

  _runDarwinTun(String proxy) async {
    late String cmd;
    if (proxy.isEmpty) {
      cmd = "delete";
      await Process.run("ifconfig", ["utun124", "down"]);
    } else {
      cmd = "add";
      await Process.run('ifconfig', [
        'utun124',
        "198.18.0.1",
        "198.18.0.1",
        "up",
      ]);
    }
    for (final address in _routeAddresses) {
      await Process.run("route", [cmd, "-net", address, "198.18.0.1"]);
    }
  }

  _runWindowsTun(String proxy) async {
    if (proxy.isNotEmpty) {
      await Process.run("netsh", [
        "interface",
        "ipv4",
        "set",
        "address",
        'name="wintun"',
        'source=static',
        'addr=192.168.123.1',
        'mask=255.255.255.0',
      ]);

      await Process.run("netsh", [
        "interface",
        "ipv4",
        "set",
        "dnsservers",
        'name="wintun"',
        'static',
        'address=8.8.8.8',
        'register=none',
        'validate=no',
      ]);
      for (final address in _routeAddresses) {
        await Process.run("netsh", [
          "interface",
          "ipv4",
          "add",
          "route",
          address,
          '"wintun"',
          "192.168.123.1",
          "metric=1"
        ]);
      }
    } else {
      for (final address in _routeAddresses) {
        await Process.run("netsh", [
          "interface",
          "ipv4",
          "delete",
          "route",
          address,
          '"wintun"',
        ]);
      }
      await Process.run("netsh", [
        "interface",
        "ipv4",
        "set",
        "dnsservers",
        'name="wintun"',
        "dhcp",
      ]);
      await Process.run("netsh", [
        "interface",
        "ipv4",
        "set",
        "address",
        'name="wintun"',
        "source=dhcp",
      ]);
    }
  }

  runTunnel(String proxy) async {
    if (proxy.isEmpty) {
      _stopTun2socks();
    } else {
      await _runTun2Socks(proxy);
      await Future.delayed(const Duration(seconds: 2));
    }
    if (Platform.isWindows) {
      await _runWindowsTun(proxy);
    } else {
      await _runDarwinTun(proxy);
    }
  }

  /// Sets the proxy on the system
  ///
  /// It causes all system traffic to pass through the proxy
  ///
  /// Supported Proxies: http, https, socks
  ///
  /// If an empty value is entered for the proxy, the proxy will be turned off
  Future<void> setSystemProxy(String proxy) async {
    if (Platform.isMacOS) {
      await _setDarwinSystemProxy(proxy);
    } else if (Platform.isWindows) {
      _setWindowsSystemProxy(proxy);
    }
  }

  /// Start V2Ray service.
  ///
  /// config:
  ///
  ///   Sing-Box Config (json)
  ///
  /// connectionType:
  ///
  ///   It sets the type of connection
  ///
  ///   ConnectionType.vpn required (Adminstrator in windows) or (root privilege in unix base system)
  Future<void> startV2Ray({
    required String config,
    ConnectionType connectionType = ConnectionType.systemProxy,
  }) async {
    if (Platform.isIOS) {
      FlutterV2rayDesktopPlatform.instance.start(jsonDecode(config));
    } else if(Platform.isAndroid){
      initAndroidV2ray(statusListner: statusListner);
      startAndroidV2ray(config);

    } else {
      _connectionType = connectionType;
      final proxy = await _validateConfig(config);
      await _runXRay(config);
      _startStatusTimer();
      if (connectionType == ConnectionType.systemProxy) {
        await setSystemProxy(proxy);
      } else if (connectionType == ConnectionType.vpn) {
        await Future.delayed(const Duration(seconds: 3));
        await runTunnel(proxy);
      }
    }
  }

  Future<void> stopV2Ray() async {
    if (Platform.isIOS) {
      FlutterV2rayDesktopPlatform.instance.stop();
    } else if (Platform.isAndroid) {
      stopAndroidV2ray();
    } else {
      _stopXRay();
      if (_connectionType == ConnectionType.systemProxy) {
        await setSystemProxy('');
      } else if (_connectionType == ConnectionType.vpn) {
        await runTunnel('');
      }
      _statusTimer?.cancel();
      statusListner.call(const V2rayStatus());
    }
  }

  int _getDelayFromOutput(String output, DelayType type) {
    switch (type) {
      case DelayType.http:
        {
          final delayString =
          RegExp(r'Real Delay\: (\-)?\d*ms').stringMatch(output);
          if (delayString == null) return -1;
          return int.tryParse(
            delayString.substring(12, delayString.length - 2),
          ) ??
              -1;
        }
      case DelayType.tcp:
        {
          final delayString =
          RegExp(r'Established TCP connection in (\-)?\d*ms')
              .stringMatch(output);
          if (delayString == null) return -1;
          return int.tryParse(
            delayString.substring(30, delayString.length - 2),
          ) ??
              -1;
        }
      case DelayType.icmp:
        {
          int count = 0;
          int total = 0;
          RegExp(r'time=(\-)?\d*ms').allMatches(output).forEach((element) {
            final delay = element[0];
            if (delay != null) {
              count++;
              total += int.tryParse(delay.substring(5, delay.length - 2)) ?? 0;
            }
          });
          if (count == 0 || total == 0) {
            return -1;
          }
          return total ~/ count;
        }
      default:
        return -1;
    }
  }

  /// This method returns the real server delay of the v2ray link.
  ///
  /// DelayType.icmp required (Adminstrator in windows) or (root privilege in unix base system)
  Future<int> getServerDelay(
      {required String url, DelayType type = DelayType.http}) async {
    final xraypath = await _getXRayPath();
    if (xraypath == null) return -1;
    final knife = path.join(xraypath, 'xray-knife');
    final output = await Process.run(knife, ['net', type.name, '-c', url]);
    return _getDelayFromOutput(output.stdout, type);
  }
}

/// Android V2ray 配置
mixin AndroidV2ray {
  FlutterV2ray? androidV2ray;

  void initAndroidV2ray({
    Function(String log)? logListner,
    Function(V2rayStatus status)? statusListner,
  }) {

    // final Duration duration;
    // final ConnectionState state;
    // final int download;
    // final int upload;
    // final int totalDownload;
    // final int totalUpload;

    androidV2ray = FlutterV2ray(
      onStatusChanged: (status) {
        /// todo 类型转换需要实测
        statusListner?.call(V2rayStatus(
          duration: Duration(seconds: int.parse(status.duration)),
          state: status.state == 'DISCONNECTED' ? ConnectionState.disconnected : ConnectionState.connected,
          download: status.download,
          upload: status.upload,
          totalDownload: status.download,
          totalUpload: status.upload,
        ));
      },
    );
  }

  Future<void> startAndroidV2ray(String config) async {
    if (androidV2ray == null) {
      return;
    }
    // You must initialize V2Ray before using it.
    await androidV2ray!.initializeV2Ray();
// v2ray share link like vmess://, vless://, ...
    String link = config;
    V2RayURL parser = FlutterV2ray.parseFromURL(link);
    androidV2ray!.startV2Ray(
      remark: parser.remark,
      config: parser.getFullConfiguration(),
      blockedApps: null,
      bypassSubnets: null,
      proxyOnly: false,
    );
  }

  void stopAndroidV2ray() {
    if (androidV2ray == null) {
      return;
    }
    androidV2ray!.stopV2Ray();
  }
}
