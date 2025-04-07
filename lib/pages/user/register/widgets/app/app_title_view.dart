import 'package:flutter/material.dart';
import 'package:yunyou_desktop/configs/index.dart';
import 'package:yunyou_desktop/themes/index.dart';

class AppTitleView extends StatelessWidget {
  const AppTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '注册${AppConfigs.appDisplayName}',
          style: AppThemes.of().semibold32text1,
        ),
        AppGaps.h6,
        Text(
          '注册成功后，您的免费试用时长会被清空，其他会员时长会被转移至账户中。您可以在手机、电脑等多设备上共享时长!',
          style: AppThemes.of().regular12text1,
        ),
      ],
    );
  }
}
