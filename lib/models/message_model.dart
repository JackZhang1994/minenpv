/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 14:27:38 
*/

class MessageModel {
  final int code;
  final String msg;
  final String data;

  MessageModel({required this.code, required this.msg, required this.data});

  factory MessageModel.init() => MessageModel(
        code: 0,
        msg: '',
        data: '',
      );

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        code: json['code'] ?? 0,
        msg: json['msg'] ?? '',
        data: json['data'] ?? '',
      );
}
