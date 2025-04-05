/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 21:01:10 
*/

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';

class TipsView extends StatelessWidget {
  const TipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 140.h),
      child: Text(
        '温馨提示\n登录成功后，本机的会员时长会转移至账户中，请勿与他人使用账户，以免造成不必要的损失！',
        style: AppThemes.of().w400Text324,
      ),
    );
  }
}
