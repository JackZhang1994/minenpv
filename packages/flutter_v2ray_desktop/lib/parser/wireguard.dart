part of 'parser.dart';

/*
PrivateKey string  
AddrV4     string  
AddrV6     string  
DNS        string  
MTU        int     
PublicKey  string  
AllowedIPs []string
Endpoint   string  
ClientID   string  
DeviceName string  
Reserved   []int   
*/

class ParserWireguard extends Parser {
  static const scheme = 'wireguard';

  ParserWireguard({
    this.privateKey,
    this.addrV4,
    this.addrV6,
    this.dns,
    this.mtu,
    this.publicKey,
    this.allowedIPs = const [],
    this.endpoint,
    this.clientID,
    this.deviceName,
    this.reserved = const [],
    required super.address,
    this.port,
  });

  String? privateKey;
  String? addrV4;
  String? addrV6;
  String? dns;
  int? mtu;
  String? publicKey;
  List<String> allowedIPs;
  String? endpoint;
  String? clientID;
  String? deviceName;
  List<int> reserved;
  int? port;

  factory ParserWireguard.parse(String rawUri) {
    if (rawUri.startsWith(scheme)) {
      rawUri = rawUri.substring(scheme.length + 3);
    }
    try {
      final JsonObject parsedData = jsonDecode(rawUri);
      return ParserWireguard(
        privateKey: parsedData['PrivateKey'],
        addrV4: parsedData['AddrV4'],
        addrV6: parsedData['AddrV6'],
        dns: parsedData['DNS'],
        mtu: parsedData['MTU'],
        publicKey: parsedData['PublicKey'],
        allowedIPs: List<String>.from(parsedData['AllowedIPs'] ?? []),
        endpoint: parsedData['Endpoint'],
        clientID: parsedData['ClientID'],
        deviceName: parsedData['DeviceName'],
        reserved: List<int>.from(parsedData['Reserved'] ?? []),
        address: parsedData['Address'],
        port: parsedData['Port'],
      );
    } catch (_) {
      throw V2rayParserError();
    }
  }

  @override
  String toString() {
    return 'ParserWireguard:\n'
        '\tprivateKey: $privateKey\n'
        '\taddrV4: $addrV4\n'
        '\taddrV6: $addrV6\n'
        '\tdns: $dns\n'
        '\tmtu: $mtu\n'
        '\tpublicKey: $publicKey\n'
        '\tallowedIPs: $allowedIPs\n'
        '\tendpoint: $endpoint\n'
        '\tclientID: $clientID\n'
        '\tdeviceName: $deviceName\n'
        '\treserved: $reserved\n'
        '\taddress: $address\n'
        '\tport: $port';
  }
}
