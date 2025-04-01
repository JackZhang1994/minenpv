part of 'parser.dart';

class SingWireguardOutbound extends SingOutbound {
  @override
  final JsonObject setting = {
    "type": "wireguard",
    "tag": "dart_v2ray_parser",
    "server": "162.159.195.81",
    "server_port": 928,
    "system_interface": false,
    "interface_name": "wg0",
    "local_address": [
      "172.16.0.2/32",
      "2606:4700:110:8bb9:68be:a130:cede:18bc/128"
    ],
    "private_key": "YNXtAzepDqRv9H52osJVDQnznT5AM11eCK3ESpwSt04=",
    "peer_public_key": "Z1XXLsKYkYxuiYjJIkRvtIKFepCYHTgON+GwPq7SOV4=",
    "mtu": 1280
  };

  SingWireguardOutbound({required ParserWireguard parser})
      : super(parser: parser) {
    if ((parser.address?.isEmpty ?? true) ||
        (parser.port == 0 || parser.port == null)) {
      return;
    }
    setting['server'] = parser.address!;
    setting['server_port'] = parser.port!;
    setting['interface_name'] = parser.deviceName;
    final localAddress = [];
    if (parser.addrV4 != null) {
      localAddress.add("${parser.addrV4}/32");
    }
    if (parser.addrV4 != null) {
      localAddress.add("${parser.addrV6}/128");
    }
    setting['local_address'] = localAddress;
    setting['private_key'] = parser.privateKey;
    setting['peer_public_key'] = parser.publicKey;
    setting['mtu'] = parser.mtu;
  }
}
