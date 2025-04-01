/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-10 15:47:22 
*/

// To parse this JSON data, do
//
//     final payModel = payModelFromJson(jsonString);

import 'dart:convert';

PayModel payModelFromJson(String str) => PayModel.fromJson(json.decode(str));

String payModelToJson(PayModel data) => json.encode(data.toJson());

class PayModel {
  String? msg;
  int? code;
  String? data;

  PayModel({
    this.msg,
    this.code,
    this.data,
  });

  factory PayModel.init() => PayModel(
        msg: '',
        code: 0,
        data: '',
      );

  factory PayModel.fromJson(Map<String, dynamic> json) => PayModel(
        msg: json["msg"],
        code: json["code"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data,
      };
}
