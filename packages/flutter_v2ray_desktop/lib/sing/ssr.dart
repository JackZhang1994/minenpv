part of 'parser.dart';

class SingSSROutbound extends SingOutbound {
  @override
  final JsonObject setting = {
    "tag": "dart_v2ray_parser",
    "type": "shadowsocksr",
    "server": "127.0.0.1",
    "server_port": 10315,
    "method": "aes-128-cfb",
    "password": ""
  };

  SingSSROutbound({required ParserSSR parser}) : super(parser: parser) {
    if ((parser.address?.isEmpty ?? true) ||
        (parser.port == 0 || parser.port == null)) {
      return;
    }
    setting['server'] = parser.address;
    setting['server_port'] = parser.port;
    setting['method'] = parser.method;
    setting['password'] = parser.password;
    if (parser.streamField?.packetEncoding?.isNotEmpty ?? false) {
      setting['packet_encoding'] = parser.streamField?.packetEncoding;
    }
    if (parser.proto?.isNotEmpty ?? false) {
      setting['protocol'] = parser.proto;
    }
    if (parser.protoParam?.isNotEmpty ?? false) {
      setting['protocol_param'] = parser.protoParam;
    }
    if (parser.obfs?.isNotEmpty ?? false) {
      setting['obfs'] = parser.obfs;
    }
    if (parser.obfsParam?.isNotEmpty ?? false) {
      setting['obfs_param'] = parser.obfsParam;
    }
  }
}
