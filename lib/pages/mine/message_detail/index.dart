import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
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
      body: SizedBox.expand(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            children: [
              Text(
                entity.noticeTitle,
                style: AppThemes.of().medium16text1,
                softWrap: true,
              ),
              AppGaps.h12,
              HtmlWidget(
                entity.noticeContent,
                textStyle: AppThemes.of().medium14text3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
