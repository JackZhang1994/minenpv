part of 'parser.dart';

const SingHTTPandTCP = {
  "type": "http",
  "host": [],
  "path": "",
};

const SingHTTPHeaders = {
  "Host": [],
};

const SingWebSocket = {
  "type": "ws",
  "path": "",
};

const SingWebsocketHeaders = {
  "Host": "",
};

const SingGRPC = {
  "type": "grpc",
  "service_name": "",
};

const SingTLS = {
  "enabled": true,
  "disable_sni": false,
  "server_name": "",
  "insecure": false,
};

const SinguTLS = {
  "enabled": false,
  "fingerprint": "",
};

const SingReality = {
  "enabled": false,
  "public_key": "",
  "short_id": "",
};

Map<dynamic, dynamic> prepareTransport(StreamField stream) {
  switch (stream.network) {
    case "tcp":
    case "http":
      {
        final j = Map.from(SingHTTPandTCP);
        String host = (stream.host?.isEmpty ?? true)
            ? stream.serverName ?? ''
            : stream.host ?? '';
        if (host.isNotEmpty) {
          j['host'] = [host];
          final h = Map.from(SingHTTPHeaders);
          h['Host'] = [host];
          j['headers'] = h;
        }
        if (stream.path?.isEmpty ?? true) {
          stream.path = '/';
        }
        setPathForSingBoxTransport(stream.path!, j);
        return j;
      }
    case "ws":
      {
        final j = Map.from(SingWebSocket);
        String host = (stream.host?.isEmpty ?? true)
            ? stream.serverName ?? ''
            : stream.host ?? '';
        if (host.isNotEmpty) {
          final h = Map.from(SingHTTPHeaders);
          h['Host'] = host;
          j['headers'] = h;
        }
        if (stream.path?.isEmpty ?? true) {
          stream.path = '/';
        }
        setPathForSingBoxTransport(stream.path!, j);
        j['early_data_header_name'] = 'Sec-WebSocket-Protocol';
        return j;
      }
    case "grpc":
      {
        final j = Map.from(SingGRPC);
        j['service_name'] = stream.grpcServiceName;
        return j;
      }
    default:
      return {};
  }
}

Map<dynamic, dynamic> prepareTls(StreamField stream) {
  switch (stream.streamSecurity) {
    case "tls":
    case "reality":
      {
        final j = Map.from(SingTLS);
        if (stream.serverName?.isEmpty ?? true) {
          stream.serverName = stream.host;
        }
        j['server_name'] = stream.serverName;
        j['enabled'] = true;
        j['insecure'] = (stream.tlsAllowInsecure?.isNotEmpty ?? false);
        if (stream.tlsalpn?.isNotEmpty ?? false) {
          j['alpn'] = stream.tlsalpn!.split(',');
        }
        if (stream.fingerprint?.isNotEmpty ?? false) {
          final utls = Map.from(SinguTLS);
          utls['enabled'] = true;
          utls['fingerprint'] = stream.fingerprint;
          j['utls'] = utls;
        }
        if ((stream.realityShortId?.isNotEmpty ?? false) &&
            (stream.realityPublicKey?.isNotEmpty ?? false)) {
          final reality = Map.from(SingReality);
          reality['short_id'] = stream.realityShortId;
          reality['public_key'] = stream.realityPublicKey;
          reality['reality'] = true;
          j['reality'] = reality;
        }
        return j;
      }
    default:
      return {'enabled': false};
  }
}

void setPathForSingBoxTransport(String path, Map j) {
  final u = parseSingBoxPathToURL(path);
  if (u != null) {
    final uPath = u.path;
    if (uPath.isNotEmpty) {
      j['path'] = uPath;
    }
    final ed = int.tryParse(u.queryParameters['ed'] ?? '');
    if (ed != null && ed > 0) {
      j['max_early_data'] = ed;
      j['early_data_header_name'] = 'Sec-WebSocket-Protocol';
    }
  }
}

Uri? parseSingBoxPathToURL(String pathStr) {
  if (pathStr.startsWith("/")) {
    pathStr = "http://www.test.com$pathStr";
  }
  return Uri.tryParse(pathStr);
}
