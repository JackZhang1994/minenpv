import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yunyou_desktop/pages/mine/message/models/message_model.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/public/app_top_bar.dart';

class MessageDetailPage extends StatelessWidget {
  const MessageDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> params = Get.arguments;
    final MessageEntity entity = params['entity'];
    return Scaffold(
      appBar: AppTopBar(
        title: '文章',
        isMobile: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              entity.title,
              style: AppThemes.of().medium16text1,
              softWrap: true,
            ),
            Text(
              entity.content,
              style: AppThemes.of().medium14text3,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
