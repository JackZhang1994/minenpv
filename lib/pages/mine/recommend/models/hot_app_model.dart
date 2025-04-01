class HotAppModel {
  final String msg;
  final int code;
  final List<HotApp> data;

  HotAppModel({
    required this.msg,
    required this.code,
    required this.data,
  });

  factory HotAppModel.fromJson(Map<String, dynamic> json) {
    return HotAppModel(
      msg: json['msg'] ?? '',
      code: json['code'] ?? 0,
      data: (json['data'] as List?)?.map((e) => HotApp.fromJson(e)).toList() ??
          [],
    );
  }

  factory HotAppModel.init() => HotAppModel(msg: '', code: 0, data: []);
}

class HotApp {
  final String logo;
  final String url;
  final String name;

  HotApp({
    required this.logo,
    required this.url,
    required this.name,
  });

  factory HotApp.fromJson(Map<String, dynamic> json) {
    return HotApp(
      logo: json['logo'] ?? '',
      url: json['url'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
