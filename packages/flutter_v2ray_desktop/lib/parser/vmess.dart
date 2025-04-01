part of 'parser.dart';

/*
vmess: ['v', 'ps', 'add', 'port', 'aid', 'scy', 'net', 'type', 'tls', 'id', 'sni', 'host', 'path', 'alpn', 'security', 'skip-cert-verify', 'fp', 'test_name', 'serverPort', 'nation']
*/

class ParserVmess extends Parser {
  static const scheme = 'vmess';

  ParserVmess({
    required super.address,
    this.port,
    this.uuid,
    this.security,
    this.aid,
    this.nation,
    this.path,
    this.ps,
    this.serverPort,
    this.skipCertVerify,
    this.testName,
    this.v,
    this.remark,
    super.streamField,
  });

  int? port;
  String? uuid;
  String? security;
  int? aid;
  String? nation;
  String? path;
  String? ps;
  String? serverPort;
  bool? skipCertVerify;
  String? testName;
  String? v;
  String? remark;

  factory ParserVmess.parse(String rawUri) {
    try {
      rawUri = rawUri.substring(scheme.length + 3);
      while (true) {
        try {
          rawUri = safeBase64Decode(rawUri);
          continue;
        } catch (_) {
          break;
        }
      }
      JsonObject j = jsonDecode(rawUri);
      if (j.isEmpty) {
        throw V2rayParserError();
      }

      String address = j['add'] ?? '';
      if (!address.contains(".")) {
        throw V2rayParserError();
      }

      String security = j['security'] ?? '';
      if (security.isEmpty) {
        security = j['scy'] ?? '';
      }

      return ParserVmess(
        address: address,
        port: int.tryParse(j['port'].toString()) ?? 0,
        uuid: j['id'] ?? '',
        aid: int.tryParse(j['aid'].toString()) ?? 0,
        security: security,
        nation: j['nation'] ?? '',
        ps: j['ps'] ?? '',
        serverPort: j['serverPort'] ?? '',
        skipCertVerify: j['skip-cert-verify'] ?? false,
        testName: j['test_name'] ?? '',
        v: j['v'] ?? '',
        remark: j['ps'] ?? '',
        streamField: StreamField(
          network: j['net'] ?? '',
          streamSecurity: j['tls'] ?? '',
          path: j['path'] ?? '',
          host: j['host'] ?? '',
          serverName: j['sni'] ?? '',
          tcpHeaderType: j['type'] ?? '',
          tlsalpn: j['alpn'] ?? '',
          fingerprint: j['fp'] ?? '',
        ),
      );
    } catch (_) {
      print(_);
      throw V2rayParserError();
    }
  }

  @override
  String toString() {
    return 'ParserVmess:\n'
        '\taddress: $address\n'
        '\tport: $port\n'
        '\tuuid: $uuid\n'
        '\taid: $aid\n'
        '\tsecurity: $security\n'
        '\tnation: $nation\n'
        '\tps: $ps\n'
        '\tserverPort: $serverPort\n'
        '\tskipCertVerify: $skipCertVerify\n'
        '\ttestName: $testName\n'
        '\tv: $v\n'
        '\tremark: $remark\n'
        '$streamField';
  }
}
