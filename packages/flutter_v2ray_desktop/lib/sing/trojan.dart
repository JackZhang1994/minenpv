part of 'parser.dart';

class SingTrojanOutbound extends SingOutbound {
  @override
  final JsonObject setting = {
    "tag": "dart_v2ray_parser",
    "type": "trojan",
    "server": "127.0.0.1",
    "server_port": 10315,
    "password": ""
  };

  SingTrojanOutbound({required ParserTrojan parser}) : super(parser: parser) {
    if ((parser.address?.isEmpty ?? true) ||
        (parser.port == 0 || parser.port == null)) {
      return;
    }
    setting['server'] = parser.address;
    setting['server_port'] = parser.port;
    setting['password'] = parser.password;
    if (parser.streamField?.packetEncoding?.isNotEmpty ?? false) {
      setting['packet_encoding'] = parser.streamField?.packetEncoding;
    }
  }
}
