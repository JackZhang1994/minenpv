part of 'parser.dart';

class SingSSOutbound extends SingOutbound {
  @override
  final JsonObject setting = {
    "tag": "dart_v2ray_parser",
    "type": "shadowsocks",
    "server": "127.0.0.1",
    "server_port": 10315,
    "method": "2022-blake3-aes-128-gcm",
    "password": ""
  };

  SingSSOutbound({required ParserSS parser}) : super(parser: parser) {
    if ((parser.address?.isEmpty ?? true) ||
        (parser.port == 0 || parser.port == null)) {
      return;
    }
    setting['server'] = parser.address;
    setting['server_port'] = parser.port;
    setting['method'] = parser.method;
    setting['password'] = parser.password;
    if (parser.plugin?.isNotEmpty ?? false) {
      setting['plugin'] = parser.plugin;
    }
    if ((parser.obfs?.isEmpty ?? false) &&
        (parser.obfsHost?.isNotEmpty ?? false)) {
      final pluginOpts = [
        "obfs=${parser.obfs}",
        "obfs-host=${parser.obfsHost}"
      ];
      setting['plugin_opts'] = pluginOpts.join(";");
    }

    final vpluginOpts = <String>[];
    if (parser.mode?.isNotEmpty ?? false) {
      vpluginOpts.add(parser.mode!);
    }
    if (vpluginOpts.isNotEmpty) {
      setting['plugin_opts'] = vpluginOpts.join(";");
    }
    if (parser.mux != null && parser.mux != 0) {
      setting['mux'] = true;
      setting['mux_concurrency'] = parser.mux;
    }
  }
}
