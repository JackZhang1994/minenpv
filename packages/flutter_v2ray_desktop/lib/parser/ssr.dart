part of 'parser.dart';

/*
shadowsocksr: ['remarks', 'obfsparam', 'protoparam', 'group']
*/

class ParserSSR extends Parser {
  static const scheme = 'ssr';
  static const SSRMethod = [
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

  static const SSROBFS = {
    "plain",
    "http_simple",
    "http_post",
    "random_head",
    "tls1.2_ticket_auth",
  };

  ParserSSR({
    required super.address,
    this.port,
    this.method,
    this.password,
    this.obfs,
    this.proto,
    this.obfsParam,
    this.protoParam,
    super.streamField,
  });

  int? port;
  String? method;
  String? password;
  String? obfs;
  String? proto;
  String? obfsParam;
  String? protoParam;

  factory ParserSSR.parse(String rawUri) {
    try {
      final r = rawUri.substring(scheme.length+3);
      final vList = r.split("?");
      late final obfsParam,
          protoParam,
          address,
          port,
          proto,
          method,
          obfs,
          password;
      if (vList.length == 2) {
        [address, port, proto, method, obfs, password] = parseMethod(vList[0]);
        [obfsParam, protoParam] = parseParams(vList[1]);
      } else {
        final vList = r.split("remarks=");
        if (vList.length == 2) {
          [address, port, proto, method, obfs, password] =
              parseMethod(vList[0]);
          [obfsParam, protoParam] = parseParams("remarks=${vList[1]}");
        }
      }

      if (!SSRMethod.contains(method)) {
        method = "rc4-md5";
      }
      if (!SSROBFS.contains(obfs)) {
        obfs = "plain";
      }

      return ParserSSR(
        address: address,
        method: method,
        obfs: obfs,
        obfsParam: obfsParam,
        password: password,
        port: port,
        proto: proto,
        protoParam: protoParam,
        streamField: StreamField(),
      );
    } catch (_) {
      throw V2rayParserError();
    }
  }

  static List<dynamic> parseParams(String s) {
    String obfsParam, protoParam;
    s = s.replaceAll('+', '-');
    s = s.replaceAll('/', '_');
    final testUrl = "https://www.test.com/?$s";
    final u = Uri.tryParse(testUrl);
    if (u == null) throw V2rayParserError();
    obfsParam = u.queryParameters['obfsparam'] ?? '';
    if (obfsParam.isNotEmpty) {
      obfsParam = safeBase64Decode(obfsParam);
    }
    protoParam = u.queryParameters['protoparam'] ?? '';
    if (protoParam.isNotEmpty) {
      protoParam = safeBase64Decode(protoParam);
    }
    return [obfsParam, protoParam];
  }

  static List<dynamic> parseMethod(String s) {
    var address, port, proto, method, obfs, password;
    final vList = s.split(":");
    if (vList.length == 6) {
      address = vList[0];
      port = int.parse(vList[1]);
      proto = vList[2];
      method = vList[3];
      obfs = vList[4];
      final p = vList[5].endsWith('/')
          ? vList[5].substring(0, vList[5].length - 1)
          : vList[5];
      password = safeBase64Decode(p);
    } else if (vList.length == 5) {
      address = vList[0];
      port = int.parse(vList[1]);
      proto = vList[2];
      method = vList[3];
      final obfsPwd = vList[4];
      for (final obfsName in SSROBFS) {
        if (obfsPwd.contains(obfsName)) {
          obfs = obfsName;
          password = safeBase64Decode(obfsPwd.substring(obfsName.length));
        }
      }
    }
    return [address, port, proto, method, obfs, password];
  }

  @override
  String toString() {
    return 'ParserSSR:\n'
        '\taddress: $address\n'
        '\tport: $port\n'
        '\tmethod: $method\n'
        '\tpassword: $password\n'
        '\tobfs: $obfs\n'
        '\tproto: $proto\n'
        '\tobfsParam: $obfsParam\n'
        '\tprotoParam: $protoParam\n'
        '$streamField';
  }
}
