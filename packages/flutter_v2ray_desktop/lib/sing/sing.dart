part of 'parser.dart';

abstract class SingOutbound {
  SingOutbound({required this.parser});

  final Parser parser;

  final JsonObject setting = {};

  JsonObject get config {
    final s = JsonObject.from(setting);
    if (parser.streamField != null && s['type'] != "shadowsocks") {
      if (s['type'] != "trojan")
        s['transport'] = prepareTransport(parser.streamField!);
      s['tls'] = prepareTls(parser.streamField!);
    }
    return s;
  }

  /// Get SignOutbound Object from uri
  ///
  /// Supported schemes: ss://, ssr//, trojan://, vless://, vmess://, wireguard://
  factory SingOutbound.fromUri(String uri) {
    final schemeIndex = uri.indexOf(':');
    if (schemeIndex == -1) throw V2rayParserError();
    final scheme = uri.substring(0, schemeIndex);
    switch (scheme) {
      case ParserSS.scheme:
        return SingSSOutbound(parser: ParserSS.parse(uri));
      case ParserSSR.scheme:
        return SingSSROutbound(parser: ParserSSR.parse(uri));
      case ParserTrojan.scheme:
        return SingTrojanOutbound(parser: ParserTrojan.parse(uri));
      case ParserVless.scheme:
        return SingVlessOutbound(parser: ParserVless.parse(uri));
      case ParserVmess.scheme:
        return SingVmessOutbound(parser: ParserVmess.parse(uri));
      case ParserWireguard.scheme:
        return SingWireguardOutbound(parser: ParserWireguard.parse(uri));
      default:
        throw V2rayParserError();
    }
  }
}
