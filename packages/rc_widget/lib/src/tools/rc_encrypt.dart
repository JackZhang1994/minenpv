/*
* @overview: 工具-数据加密
* @Author: rcc 
* @Date: 2022-12-05 13:46:02 
*/

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class RcEncrypt {
  RcEncrypt._();

  static bool isInit = false;
  static late Encrypter encrypter;

  static void init({
    required String rsaKey,
  }) {
    RcEncrypt.isInit = true;

    final publicKey = RSAKeyParser().parse(rsaKey) as dynamic;
    RcEncrypt.encrypter = encrypter = Encrypter(RSA(publicKey: publicKey));
  }

  /// RSA加密
  static String encodeRsa(String text) {
    assert(isInit, 'RcEncrypt Uninitialized');

    return encrypter.encrypt(text).base64;
  }

  /// MD5加密
  static String encodeMd5(String text) {
    final bytes = utf8.encode(text);

    return md5.convert(bytes).toString();
  }
}
