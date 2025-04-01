part of 'parser.dart';

/*
shadowsocks: ['plugin', 'obfs', 'obfs-host', 'mode', 'path', 'mux', 'host']
*/

class ParserSS extends Parser {
  static const scheme = 'ss';
  static const List<String> SSMethod = [
    "2022-blake3-aes-128-gcm",
    "2022-blake3-aes-256-gcm",
    "2022-blake3-chacha20-poly1305",
    "none",
    "aes-128-gcm",
    "aes-192-gcm",
    "aes-256-gcm",
    "chacha20-ietf-poly1305",
    "xchacha20-ietf-poly1305",
    "aes-128-ctr",
    "aes-192-ctr",
    "aes-256-ctr",
    "aes-128-cfb",
    "aes-192-cfb",
    "aes-256-cfb",
    "rc4-md5",
    "chacha20-ietf",
    "xchacha20",
  ];

  ParserSS({
    required super.address,
    this.port,
    this.method,
    this.password,
    this.host,
    this.mode,
    this.mux,
    this.path,
    this.plugin,
    this.obfs,
    this.obfsHost,
    super.streamField,
  });

  int? port;
  String? method;
  String? password;
  String? host;
  String? mode;
  String? mux;
  String? path;
  String? plugin;
  String? obfs;
  String? obfsHost;

  factory ParserSS.parse(String rawUri) {
    rawUri = rawUri.replaceAll("#ss#\u00261@", "@");
    final u = Uri.tryParse(rawUri);
    if (u == null) throw V2rayParserError();

    try {
      String method = u.userInfo.split(':')[0];
      if (method == "rc4") {
        method = "rc4-md5";
      }
      if (!SSMethod.contains(method)) {
        method = "none";
      }

      return ParserSS(
        address: u.host,
        port: int.tryParse(u.port.toString()) ?? 0,
        host: u.queryParameters['host'] ?? '',
        method: method,
        mode: u.queryParameters['mode'] ?? '',
        // mux: u.queryParameters['mux'] ?? '',
        obfs: u.queryParameters['obfs'] ?? '',
        obfsHost: u.queryParameters['obfs-host'] ?? '',
        password: u.userInfo.split(':')[1],
        path: u.queryParameters['path'] ?? '',
        plugin: u.queryParameters['plugin'] ?? '',
        streamField: StreamField(),
      );
    } catch (_) {
      throw V2rayParserError();
    }
  }
}
