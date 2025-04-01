import 'dart:convert';

String safeBase64Decode(String source) {
  final l = source.length % 4;
  if (l != 0) {
    source += '=' * (4 - l);
  }
  return utf8.decode(base64Decode(source));
}
