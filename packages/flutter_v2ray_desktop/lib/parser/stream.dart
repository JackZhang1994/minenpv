part of 'parser.dart';

class StreamField {
  StreamField({
    this.network,
    this.streamSecurity,
    this.path,
    this.host,
    this.tcpHeaderType,
    this.grpcServiceName,
    this.grpcMultiMode,
    this.serverName,
    this.tlsalpn,
    this.tlsAllowInsecure,
    this.fingerprint,
    this.realityShortId,
    this.realitySpiderX,
    this.realityPublicKey,
    this.packetEncoding,
  });

  String? network;
  String? streamSecurity;
  String? path;
  String? host;
  String? tcpHeaderType;
  String? grpcServiceName;
  String? grpcMultiMode;
  String? serverName;
  String? tlsalpn;
  String? tlsAllowInsecure;
  String? fingerprint;
  String? realityShortId;
  String? realitySpiderX;
  String? realityPublicKey;
  String? packetEncoding;

  @override
  String toString() {
    return 'StreamField:\n'
        '\tnetwork: $network\n'
        '\tstreamSecurity: $streamSecurity\n'
        '\tpath: $path\n'
        '\thost: $host\n'
        '\ttcpHeaderType: $tcpHeaderType\n'
        '\tgrpcServiceName: $grpcServiceName\n'
        '\tgrpcMultiMode: $grpcMultiMode\n'
        '\tserverName: $serverName\n'
        '\ttlsalpn: $tlsalpn\n'
        '\ttlsAllowInsecure: $tlsAllowInsecure\n'
        '\tfingerprint: $fingerprint\n'
        '\trealityShortId: $realityShortId\n'
        '\trealitySpiderX: $realitySpiderX\n'
        '\trealityPublicKey: $realityPublicKey\n'
        '\tpacketEncoding: $packetEncoding';
  }
}
