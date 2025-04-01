import 'dart:convert';

import '../v2ray_parser.dart';

part 'sing.dart';
part 'ss.dart';
part 'ssr.dart';
part 'stream.dart';
part 'trojan.dart';
part 'vless.dart';
part 'vmess.dart';
part 'wireguard.dart';

class V2raySingParser {
  final List<JsonObject> outbounds = [];
  final List<JsonObject> inbounds = [];
  final JsonObject ntp = {};
  final JsonObject log = {};
  final JsonObject route = {};
  final JsonObject experimental = {};
  final JsonObject dns = {};

  V2raySingParser();

  factory V2raySingParser.quick(SingOutbound outbound) {
    final sing = V2raySingParser();
    sing.addOutbound({"tag": "direct", "type": "direct"});
    sing.addOutbound({"tag": "bypass", "type": "direct"});
    sing.addOutbound({"tag": "block", "type": "block"});
    sing.addOutbound({"tag": "dns-out", "type": "dns"});
    // sing.config['log'] = {"loglevel": "warning"};
    sing.addOutbound(outbound.config);
    sing.route.addAll({
      "auto_detect_interface": true,
      "override_android_vpn": true,
      "final": outbound.setting['tag'],
      "rule_set": [
        {
          "type": "remote",
          "tag": "geoip-cn",
          "format": "binary",
          "url":
              "https://mirror.ghproxy.com/https://github.com/SagerNet/sing-geoip/raw/rule-set/geoip-cn.srs",
          "download_detour": "direct"
        }
      ],
      "rules": [
        {
          "outbound": "dns-out",
          "port": [53]
        },
        {
          "inbound": ["dns-in"],
          "outbound": "dns-out"
        },
        {
          "domain_suffix": ["ir"],
          "outbound": "bypass"
        },
        {
          "protocol": "quic",
          "port": [443],
          "outbound": "block"
        },
        {
          "ip_cidr": ["224.0.0.0/3", "ff00::/8"],
          "outbound": "block",
          "source_ip_cidr": ["224.0.0.0/3", "ff00::/8"]
        }
      ]
    });
    sing.experimental.addAll({
      "v2ray_api": {
        "listen": "127.0.0.1:18194",
        "stats": {
          "enabled": true,
          "inbounds": ["mixed-in", "dns-in"]
        }
      }
    });
    sing.dns.addAll({
      "servers": [
        {
          "tag": "dns-remote",
          "address": "tcp://8.8.8.8",
          "address_resolver": "dns-direct"
        },
        {
          "tag": "dns-direct",
          "address": "8.8.8.8",
          "address_resolver": "dns-local",
          "detour": "direct"
        },
        {"tag": "local_local", "address": "223.5.5.5", "detour": "direct"},
        {"tag": "dns-local", "address": "local", "detour": "direct"},
        {"tag": "dns-block", "address": "rcode://success"}
      ],
      "rules": [
        {
          "server": "local_local",
          "domain": [outbound.config["server"]]
        },
      ],
      "independent_cache": true
    });
    sing.inbounds.add(
      {
        "domain_strategy": "prefer_ipv4",
        "listen": "127.0.0.1",
        "listen_port": 10315,
        "sniff": true,
        "sniff_override_destination": false,
        "tag": "mixed-in",
        "type": "mixed"
      },
    );
    sing.inbounds.add({
      "type": "direct",
      "tag": "dns-in",
      "listen": "127.0.0.1",
      "listen_port": 6450,
      "override_address": "8.8.8.8",
      "override_port": 53
    });
    return sing;
  }

  void addOutbound(JsonObject config) {
    if (getTagIndex(config['tag']) == null) {
      outbounds.add(config);
    } else {
      throw V2rayParserError(V2rayParserErrorType.tagIsExist);
    }
  }

  void removeOutbound(String tag) {
    final index = getTagIndex(tag);
    if (index == null) {
      throw V2rayParserError(V2rayParserErrorType.tagNotFounded);
    }
    outbounds.removeAt(index);
  }

  int? getTagIndex(String? tag) {
    int index = outbounds.indexWhere((element) => element['tag'] == tag);
    return index == -1 ? null : index;
  }

  JsonObject get config {
    return {
      'log': log,
      'dns': dns,
      'ntp': ntp,
      'inbounds': inbounds,
      'outbounds': outbounds,
      'route': route,
      'experimental': experimental,
    };
  }

  String json({String indent = ' ', int indentCount = 2}) {
    return JsonEncoder.withIndent(indent * indentCount).convert(config);
  }
}
