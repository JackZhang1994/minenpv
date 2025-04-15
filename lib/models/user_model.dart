/*
 */
/*
 */
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? msg;
  int? code;
  Data? data;

  UserModel({
    this.msg,
    this.code,
    this.data,
  });

  factory UserModel.init() => UserModel(
        msg: '',
        code: 0,
        data: Data.init(),
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        msg: json["msg"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data?.toJson(),
      };
}

class Data {
  int? uid;
  dynamic email;
  int? invites;
  int? rewardDuration;
  int? vipType;
  int? receiveVipCount;
  DateTime? vipEndTime;
  int? isToDayReward;
  String? username;

  Data({
    this.uid,
    this.email,
    this.invites,
    this.rewardDuration,
    this.vipType,
    this.receiveVipCount,
    this.vipEndTime,
    this.isToDayReward,
    this.username,
  });

  factory Data.init() => Data(
        uid: 0,
        email: '',
        invites: 0,
        rewardDuration: 0,
        vipType: 0,
        receiveVipCount: 0,
        vipEndTime: DateTime.parse('1970-01-01 08:00:00.000Z'),
        isToDayReward: 0,
        username: '',
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        uid: json["uid"],
        email: json["email"],
        invites: json["invites"],
        rewardDuration: json["rewardDuration"],
        vipType: json["vipType"],
        receiveVipCount: json["receiveVipCount"],
        vipEndTime: DateTime.parse(json["vipEndTime"] ?? "1970-01-01 08:00:00.000Z"),
        isToDayReward: json["isToDayReward"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "invites": invites,
        "rewardDuration": rewardDuration,
        "vipType": vipType,
        "receiveVipCount": receiveVipCount,
        "vipEndTime": vipEndTime?.toIso8601String(),
        "isToDayReward": isToDayReward,
        "username": username,
      };
}
