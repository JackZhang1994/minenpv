import 'dart:convert';

class DeviceListModel {
  final String msg;
  final int code;
  final int total;
  final List<DeviceEntity> rows;

  DeviceListModel({
    required this.msg,
    required this.code,
    required this.total,
    required this.rows,
  });

  factory DeviceListModel.fromJson(Map<String, dynamic> json) {
    return DeviceListModel(
      msg: json['msg'] ?? '',
      code: json['code'] ?? 0,
      total: json['total'] ?? 0,
      rows: (json['rows'] as List?)?.map((e) => DeviceEntity.fromJson(e)).toList() ?? [],
    );
  }

  factory DeviceListModel.init() => DeviceListModel(msg: '', code: 0, total: 0, rows: []);
}

class DeviceEntity {
  final int id;
  final String deviceId;
  final String deviceInfo;
  final String delFlag;

  DeviceEntity({
    required this.id,
    required this.deviceId,
    required this.deviceInfo,
    required this.delFlag,
  });

  String get deviceName {
    if (deviceInfo.isNotEmpty) {
      Map<String, dynamic> map = jsonDecode(deviceInfo);
      if (map.isNotEmpty && map.containsKey('platform')) {
        return map['platform'];
      }
    }
    return '';
  }

  factory DeviceEntity.init() => DeviceEntity(
        id: 0,
        deviceId: 'abcdefg',
        deviceInfo: 'abcdefg',
        delFlag: '0',
      );

  factory DeviceEntity.fromJson(Map<String, dynamic> json) {
    return DeviceEntity(
      id: json['id'] ?? 0,
      deviceId: json['deviceId'] ?? '',
      deviceInfo: json['deviceInfo'] ?? '',
      delFlag: json['delFlag'] ?? '0',
    );
  }
}
