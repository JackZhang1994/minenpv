class UploadModel {
  final String msg;
  final int code;
  final String data;

  UploadModel({
    required this.msg,
    required this.code,
    required this.data,
  });

  factory UploadModel.fromJson(Map<String, dynamic> json) {
    return UploadModel(
      msg: json['msg'] ?? '',
      code: json['code'] ?? 0,
      data: json['data'] ?? '',
    );
  }

  factory UploadModel.init() => UploadModel(msg: '', code: 0, data: '');
}
