part of 'parser.dart';

class SingVlessOutbound extends SingOutbound {
  @override
  final JsonObject setting = {
    "tag": "dart_v2ray_parser",
    "type": "vless",
    "server": "127.0.0.1",
    "server_port": 10315,
    "uuid": "bf000d23-0752-40b4-affe-68f7707a9661",
    "flow": ""
  };

  SingVlessOutbound({required ParserVless parser}) : super(parser: parser) {
    if ((parser.address?.isEmpty ?? true) ||
        (parser.port == 0 || parser.port == null)) {
      return;
    }
    setting['server'] = parser.address;
    setting['server_port'] = parser.port;
    setting['uuid'] = parser.uuid;
    setting['flow'] = parser.flow;
    if (parser.streamField?.packetEncoding?.isNotEmpty ?? false) {
      setting['packet_encoding'] = parser.streamField?.packetEncoding;
    }
  }
}
