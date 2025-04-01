/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 21:01:10 
*/

import 'package:flutter/material.dart';

import '/themes/index.dart';

class TipsView extends StatelessWidget {
  const TipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '温馨提示\n页面显示为美元价格，支付时自动转换成您常用的货币价格。如充值成功不到账。请您重启APP；或直接联系在线客服，我们会及时解决，谢谢。',
      style: AppThemes.of().w400Text324,
    );
  }
}
