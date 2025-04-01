/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-30 22:02:31 
*/

class PriceModel {
  final int ret;
  final String need;

  PriceModel({
    required this.ret,
    required this.need,
  });

  factory PriceModel.init() => PriceModel(
        ret: 0,
        need: '0',
      );

  factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
        ret: json['ret'] ?? 0,
        need: json['need'] ?? '0',
      );
}
