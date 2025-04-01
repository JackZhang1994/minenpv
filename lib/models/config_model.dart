// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) =>
    ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  String? msg;
  int? code;
  Config? data;

  ConfigModel({
    this.msg,
    this.code,
    this.data,
  });

  factory ConfigModel.init() => ConfigModel(
        msg: '',
        code: 0,
        data: Config.init(),
      );

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        msg: json["msg"],
        code: json["code"],
        data: json["data"] == null ? null : Config.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data?.toJson(),
      };
}

class Config {
  String? website;
  String? community;
  String? onlineService;
  String? shareIntr;
  int? dailyGiftVipDuration;
  int? firstDailyGiftVipDuration;
  String? startNotice;
  String? rollNotice;
  String? rechargeTips;
  String? mainBanner;
  String? androidVersion;
  String? privacyPolicy;
  DateTime? createTime;

  Config({
    this.website,
    this.community,
    this.onlineService,
    this.shareIntr,
    this.dailyGiftVipDuration,
    this.firstDailyGiftVipDuration,
    this.startNotice,
    this.rollNotice,
    this.rechargeTips,
    this.mainBanner,
    this.androidVersion,
    this.privacyPolicy,
    this.createTime,
  });

  factory Config.init() => Config(
        website: '',
        community: '',
        onlineService: '',
        shareIntr: '',
        dailyGiftVipDuration: 0,
        firstDailyGiftVipDuration: 0,
        startNotice: '',
        rollNotice: '',
        rechargeTips: '',
        mainBanner: '',
        androidVersion: '',
        privacyPolicy: '',
        createTime: null,
      );

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        website: json["website"],
        community: json["community"],
        onlineService: json["onlineService"],
        shareIntr: json["shareIntr"],
        dailyGiftVipDuration: json["dailyGiftVipDuration"],
        firstDailyGiftVipDuration: json["firstDailyGiftVipDuration"],
        startNotice: json["startNotice"],
        rollNotice: json["rollNotice"],
        rechargeTips: json["rechargeTips"],
        mainBanner: json["mainBanner"],
        androidVersion: json["androidVersion"],
        privacyPolicy: json["privacyPolicy"],
        createTime: json["createTime"] == null
            ? null
            : DateTime.parse(json["createTime"]),
      );

  Map<String, dynamic> toJson() => {
        "website": website,
        "community": community,
        "onlineService": onlineService,
        "shareIntr": shareIntr,
        "dailyGiftVipDuration": dailyGiftVipDuration,
        "firstDailyGiftVipDuration": firstDailyGiftVipDuration,
        "startNotice": startNotice,
        "rollNotice": rollNotice,
        "rechargeTips": rechargeTips,
        "mainBanner": mainBanner,
        "androidVersion": androidVersion,
        "privacyPolicy": privacyPolicy,
        "createTime": createTime?.toIso8601String(),
      };
}
