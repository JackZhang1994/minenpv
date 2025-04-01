/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-10 21:03:09 
*/

class InviteModel {
  final InviteInfo inviteInfo;
  final int ret;

  InviteModel({
    required this.inviteInfo,
    required this.ret,
  });

  factory InviteModel.init() => InviteModel(
        ret: 0,
        inviteInfo: InviteInfo.init(),
      );

  factory InviteModel.fromJson(Map<String, dynamic> json) => InviteModel(
        ret: json['ret'] ?? 0,
        inviteInfo: json['inviteInfo'] == null ? InviteInfo.init() : InviteInfo.fromJson(json['inviteInfo']),
      );
}

class InviteInfo {
  final Code code;
  final int paybacksSum;
  final int inviteGift;
  final double codePayback;

  InviteInfo({
    required this.code,
    required this.paybacksSum,
    required this.inviteGift,
    required this.codePayback,
  });

  factory InviteInfo.init() => InviteInfo(
        code: Code.init(),
        paybacksSum: 0,
        inviteGift: 0,
        codePayback: 0,
      );

  factory InviteInfo.fromJson(Map<String, dynamic> json) => InviteInfo(
        code: json['code'] == null ? Code.init() : Code.fromJson(json['code']),
        paybacksSum: json['paybacks_sum'] ?? 0,
        inviteGift: json['invite_gift'] ?? 0,
        codePayback: json['code_payback']?.toDouble() ?? 0,
      );
}

class Code {
  final int id;
  final String code;
  final int userId;

  Code({
    required this.id,
    required this.code,
    required this.userId,
  });

  factory Code.init() => Code(
        id: 0,
        code: '****',
        userId: 0,
      );

  factory Code.fromJson(Map<String, dynamic> json) => Code(
        id: json['id'] ?? 0,
        code: json['code'] ?? '',
        userId: json['user_id'] ?? 0,
      );
}
