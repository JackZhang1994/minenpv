/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-20 22:14:38 
*/

// To parse this JSON data, do
//
//     final subscribeNode = subscribeNodeFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

SubscribeNodeList subscribeNodeListFromJson(String str) =>
    SubscribeNodeList.fromJson(json.decode(str));

String subscribeNodeListToJson(SubscribeNodeList data) =>
    json.encode(data.toJson());

class SubscribeNodeList {
  String? msg;
  int? code;
  RxList<SubscribeNode> data;

  SubscribeNodeList({
    this.msg,
    this.code,
    required this.data,
  });

  factory SubscribeNodeList.init() => SubscribeNodeList(
        msg: '',
        code: 0,
        data: RxList<SubscribeNode>(),
      );

  factory SubscribeNodeList.fromJson(Map<String, dynamic> json) =>
      SubscribeNodeList(
        msg: json["msg"],
        code: json["code"],
        data: json["data"] == null
            ? RxList()
            : RxList<SubscribeNode>.from(
                json["data"]!.map((x) => SubscribeNode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

NodeInfo nodeInfoFromJson(String str) => NodeInfo.fromJson(json.decode(str));

String nodeInfoToJson(NodeInfo data) => json.encode(data.toJson());

class NodeInfo {
  String? msg;
  int? code;
  SubscribeNode? data;

  NodeInfo({
    this.msg,
    this.code,
    this.data,
  });

  factory NodeInfo.init() => NodeInfo(
        msg: '',
        code: 0,
        data: SubscribeNode.init(),
      );

  factory NodeInfo.fromJson(Map<String, dynamic> json) => NodeInfo(
        msg: json["msg"],
        code: json["code"],
        data:
            json["data"] == null || json["data"] is! Map<String, dynamic> ? null : SubscribeNode.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data?.toJson(),
      };
}

class SubscribeNode {
  int? id;
  String? title;
  String? algorithm;
  String? password;
  String? url;
  int? port;
  int? vipType;
  String? icon;
  int? useCount;

  SubscribeNode({
    this.id,
    this.title,
    this.algorithm,
    this.password,
    this.url,
    this.port,
    this.vipType,
    this.icon,
    this.useCount,
  });

  factory SubscribeNode.init() => SubscribeNode(
        id: 0,
        title: '',
        algorithm: '',
        password: '',
        url: '',
        port: 0,
        vipType: 0,
        icon: '',
        useCount: 0,
      );

  factory SubscribeNode.fromJson(Map<String, dynamic> json) => SubscribeNode(
        id: json["id"],
        title: json["title"],
        algorithm: json["algorithm"],
        password: json["password"],
        url: json["url"],
        port: json["port"],
        vipType: json["vipType"],
        icon: json["icon"],
        useCount: json["useCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "algorithm": algorithm,
        "password": password,
        "url": url,
        "port": port,
        "vipType": vipType,
        "icon": icon,
        "useCount": useCount,
      };
}
