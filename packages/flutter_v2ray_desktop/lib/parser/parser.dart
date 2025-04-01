import 'dart:convert';

import '../errors/errors.dart';
import '../utils/utils.dart';

part 'ss.dart';
part 'ssr.dart';
part 'stream.dart';
part 'trojan.dart';
part 'vless.dart';
part 'vmess.dart';
part 'wireguard.dart';


typedef JsonObject = Map<String, dynamic>;

abstract class Parser {
  final String address;
  Parser({required this.address, this.streamField});

  StreamField? streamField;
}
