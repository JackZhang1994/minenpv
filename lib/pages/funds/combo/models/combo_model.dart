/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-10 09:52:38 
*/

// To parse this JSON data, do
//
//     final comboModel = comboModelFromJson(jsonString);

import 'dart:convert';
import 'package:get/get.dart';

ComboModel comboModelFromJson(String str) =>
    ComboModel.fromJson(json.decode(str));

String comboModelToJson(ComboModel data) => json.encode(data.toJson());

class ComboModel {
  String? msg;
  int? code;
  RxList<Shop> data;

  ComboModel({
    this.msg,
    this.code,
    required this.data,
  });

  factory ComboModel.init() => ComboModel(
        msg: '',
        code: 0,
        data: RxList<Shop>(),
      );

  factory ComboModel.fromJson(Map<String, dynamic> json) => ComboModel(
        msg: json["msg"],
        code: json["code"],
        data: json["data"] == null
            ? RxList()
            : RxList<Shop>.from(json["data"]!.map((x) => Shop.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data == null
            ? []
            : RxList<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Shop {
  int? id;
  int? vipType;
  String title;
  double? price;
  double? oldPrice;
  int? vipDuration;
  DateTime? endTime;

  Shop({
    this.id,
    this.vipType,
    required this.title,
    this.price,
    this.oldPrice,
    this.vipDuration,
    this.endTime,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        vipType: json["vipType"],
        title: json["title"],
        price: json["price"],
        oldPrice: json["oldPrice"],
        vipDuration: json["vipDuration"],
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vipType": vipType,
        "title": title,
        "price": price,
        "oldPrice": oldPrice,
        "vipDuration": vipDuration,
        "endTime": endTime?.toIso8601String(),
      };
}
