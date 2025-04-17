class CreateOrderModel {
  final int code;
  final String msg;
  final CreateOrderEntity data;

  CreateOrderModel({required this.code, required this.msg, required this.data});

  factory CreateOrderModel.init() => CreateOrderModel(
        code: 0,
        msg: '',
        data: CreateOrderEntity.init(),
      );

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) => CreateOrderModel(
        code: json['code'] ?? 0,
        msg: json['msg'] ?? '',
        data: CreateOrderEntity.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
      );
}

class CreateOrderEntity {
  final String orderId;
  final String content;
  final int vipType;
  final num paymentAmount;
  final int status;
  final String createTime;
  final String payUrl;
  final dynamic payNo;

  CreateOrderEntity({
    required this.orderId,
    required this.content,
    required this.vipType,
    required this.paymentAmount,
    required this.status,
    required this.createTime,
    required this.payUrl,
    required this.payNo,
  });

  factory CreateOrderEntity.init() => CreateOrderEntity(
        orderId: '',
        content: '',
        vipType: 2,
        paymentAmount: 100,
        status: 0,
        createTime: '1970-01-01',
        payUrl: '',
        payNo: null,
      );

  factory CreateOrderEntity.fromJson(Map<String, dynamic> json) => CreateOrderEntity(
        orderId: json['orderId'] ?? '',
        content: json['content'] ?? '',
        vipType: json['vipType'] ?? 0,
        paymentAmount: json['paymentAmount'] ?? 0,
        status: json['status'] ?? 0,
        createTime: json['createTime'] ?? '1970-01-01',
        payUrl: json['payUrl'] ?? '',
        payNo: json['payNo'],
      );
}
