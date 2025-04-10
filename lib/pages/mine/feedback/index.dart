import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/pages/mine/feedback/widgets/app/app_form_view.dart';
import 'package:yunyou_desktop/widgets/public/app_button.dart';
import 'package:yunyou_desktop/widgets/public/app_top_bar.dart';

import 'controllers/feedback_controller.dart';

class FeedbackPage extends GetView<FeedbackController> {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppTopBar(
        title: '反馈问题',
        isMobile: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: AppFormView(),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Obx(
          () => Visibility(
            visible: controller.btnEnabled.isTrue,
            replacement: AppDisabledButton(text: '提交'),
            child: AppButton(
              text: '提交',
              onTap: controller.addFeedback,
            ),
          ),
        ),
      ),
    );
  }
}

class FeedbackPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FeedbackController>(FeedbackController());
  }
}
