/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 10:13:09 
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';

import '/themes/index.dart';
import '../../controllers/acombo_controller.dart';
import '../../models/combo_model.dart';

class ComboView extends StatelessWidget {
  const ComboView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: AppSpacings.h32,
        child: CustomScrollView(
          slivers: [
            _buildGrid(),
            _buildTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    final s = ComboController.to;

    return Obx(() {
      return SliverGrid.builder(
        itemCount: s.combos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 60.h,
          crossAxisSpacing: 46.w,
          childAspectRatio: 320 / 156,
        ),
        itemBuilder: (_, int index) {
          return CardView(s.combos[index]);
        },
      );
    });
  }

  Widget _buildTips() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 60.h, bottom: 20.h),
        child: Text(
          '温馨提示\n页面显示为CNY价格，支付时自动转换成您常用的货币价格。如充值成功不到账。请您重启APP；或直接联系在线客服，我们会及时解决，谢谢。',
          style: AppThemes.of().w400Text324,
        ),
      ),
    );
  }
}

class CardView extends StatelessWidget {
  const CardView(this.data, {super.key});

  final Shop data;

  @override
  Widget build(BuildContext context) {
    return RcGestureDetector(
      onTap: () => ComboController.to.placeOrder(data),
      child: Container(
        decoration: data.endTime == null ? AppThemes.of().card3 : AppThemes.of().card5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data.title,
              style: AppThemes.of().w400Text136,
            ),
            Padding(
              padding: AppSpacings.v8,
              child: Text(
                '￥ ${data.price}',
                style: AppThemes.of().w500Text152,
              ),
            ),
            // Text(
            //   '折合 $convert/天',
            //   style: AppThemes.of().w400Text328,
            // )
          ],
        ),
      ),
    );
  }
}
