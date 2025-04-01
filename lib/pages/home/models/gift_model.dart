/*
 */
// To parse this JSON data, do
//
//     final giftModel = giftModelFromJson(jsonString);

import 'dart:convert';

GiftModel giftModelFromJson(String str) => GiftModel.fromJson(json.decode(str));

String giftModelToJson(GiftModel data) => json.encode(data.toJson());

class GiftModel {
  String? msg;
  int? code;

  GiftModel({
    this.msg,
    this.code,
  });

  factory GiftModel.init() => GiftModel(msg: '', code: 0);

  factory GiftModel.fromJson(Map<String, dynamic> json) => GiftModel(
        msg: json["msg"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
      };
}
