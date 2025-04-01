part of 'parser.dart';

/*
trojan: ['allowInsecure', 'peer', 'sni', 'type', 'path', 'security', 'headerType']
*/

// 判断 query['peer'] 是域名还是 IP

class ParserTrojan extends Parser {
  static const scheme = 'trojan';

  ParserTrojan({
    required super.address,
    this.port,
    this.password,
    this.remark,
    super.streamField,
  });

  int? port;
  String? password;
  String? remark;

  factory ParserTrojan.parse(String rawUri) {
    final u = Uri.tryParse("$rawUri&security=tls&type=tcp&headerType=none");
    if (u == null) throw V2rayParserError();

    final query = u.queryParameters;

//判断query['peer']是域名还是ip

    final streamField = StreamField(
      network: query['type'],
      host: query['peer'],
      path: query['path'],
      streamSecurity: query['security'],
      serverName: query['sni'],
      tcpHeaderType: query['headerType'],
      tlsAllowInsecure: query['allowInsecure'],
    );
    streamField.tlsAllowInsecure ??= "false";

    if (streamField.tlsAllowInsecure != null &&
        streamField.serverName != null) {
      streamField.network ??= "tcp";
      streamField.streamSecurity ??= "tls";
      streamField.host ??= streamField.serverName;
      streamField.serverName ??= u.host;
    } else {
      streamField.network = "tcp";
      streamField.tcpHeaderType = "none";
    }
    return ParserTrojan(
      address: u.host,
      port: u.port,
      password: u.userInfo,
      remark: Uri.decodeComponent(u.fragment),
      streamField: streamField,
    );
  }

  @override
  String toString() {
    return 'ParserTrojan:\n'
        '\taddress: $address\n'
        '\tport: $port\n'
        '\tpassword: $password\n'
        '\tremark: $remark\n'
        '$streamField';
  }
}
