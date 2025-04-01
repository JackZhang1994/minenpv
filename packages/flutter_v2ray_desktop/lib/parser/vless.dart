part of 'parser.dart';

/*
vless: ['security', 'type', 'sni', 'path', 'encryption', 'headerType', 'packetEncoding', 'serviceName', 'mode', 'flow', 'alpn', 'host', 'fp', 'pbk', 'sid', 'spx']
*/

class ParserVless extends Parser {
  static const scheme = 'vless';

  ParserVless({
    required super.address,
    this.port,
    this.uuid,
    this.encryption,
    this.flow,
    this.remark,
    super.streamField,
  });

  int? port;
  String? uuid;
  String? encryption;
  String? flow;
  String? remark;

  factory ParserVless.parse(String rawUri) {
    final r = Uri.tryParse(rawUri);
    if (r == null) throw V2rayParserError();
    String flow = r.queryParameters['flow'] ?? '';
    if (flow == 'xtls-rprx-direct-udp443') {
      flow = 'xtls-rprx-vision-udp443';
    }

    return ParserVless(
      address: r.host,
      port: r.port,
      uuid: r.userInfo,
      encryption: r.queryParameters['encryption'] ?? 'none',
      flow: flow,
      remark: Uri.decodeComponent(r.fragment),
      streamField: StreamField(
        network: r.queryParameters['type'],
        streamSecurity: r.queryParameters['security'],
        path: r.queryParameters['path'],
        host: r.queryParameters['host'],
        grpcServiceName: r.queryParameters['serviceName'],
        grpcMultiMode: r.queryParameters['mode'],
        serverName: r.queryParameters['sni'],
        tlsalpn: r.queryParameters['alpn'],
        fingerprint: r.queryParameters['fp'],
        realityShortId: r.queryParameters['sid'],
        realitySpiderX: r.queryParameters['spx'],
        realityPublicKey: r.queryParameters['pbk'],
        packetEncoding: r.queryParameters['packetEncoding'],
        tcpHeaderType: r.queryParameters['headerType'],
      ),
    );
  }

  @override
  String toString() {
    return 'ParserVless:\n'
        '\taddress: $address\n'
        '\tport: $port\n'
        '\tuuid: $uuid\n'
        '\tencryption: $encryption\n'
        '\tflow: $flow\n'
        '\tremark: $remark\n'
        '$streamField';
  }
}
