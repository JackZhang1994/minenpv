part of 'parser.dart';

class SingVmessOutbound extends SingOutbound {
  @override
  final JsonObject setting = {
    "type": "vmess",
    "tag": "dart_v2ray_parser",
    "server": "127.0.0.1",
    "server_port": 10315,
    "uuid": "",
    "security": "auto",
    "alter_id": 0
  };

  SingVmessOutbound({required ParserVmess parser}) : super(parser: parser) {
    if ((parser.address?.isEmpty ?? true) ||
        (parser.port == 0 || parser.port == null)) {
      return;
    }
    setting['server'] = parser.address;
    setting['server_port'] = parser.port;
    setting['uuid'] = parser.uuid;
    setting['alter_id'] = parser.aid;
    if (parser.security?.isEmpty ?? true) {
      parser.security = 'none';
    }
    setting['security'] = parser.security;
    if (parser.streamField?.packetEncoding?.isNotEmpty ?? false) {
      setting['packet_encoding'] = parser.streamField?.packetEncoding;
    }
  }
}
