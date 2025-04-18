import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:yunyou_desktop/controllers/base/app_getx_controller.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/public/app_empty_view.dart';
import 'package:yunyou_desktop/widgets/public/app_error_view.dart';
import 'package:yunyou_desktop/widgets/public/app_top_bar.dart';

import 'controllers/message_controller.dart';
import 'widgets/app/app_message_card.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppTopBar(
        title: '消息中心',
        isMobile: true,
      ),
      body: Obx(
        () => Visibility(
          visible: controller.loadStatus != LoadStatus.error,
          replacement: AppErrorView(),
          child: Skeletonizer(
            enabled: controller.loadStatus == LoadStatus.load,
            child: Obx(
              () => Visibility(
                visible: controller.data.isNotEmpty,
                replacement: AppEmptyView(),
                child: SizedBox.expand(
                  child: EasyRefresh(
                    controller: controller.refreshController,
                    onRefresh: () async {
                      await controller.onRefresh();
                    },
                    onLoad: () async {
                      if (controller.data.length == controller.total) {
                        return IndicatorResult.noMore;
                      }
                      await controller.onLoadMore();
                    },
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      itemBuilder: (context, index) {
                        return AppMessageCard(entity: controller.data[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return AppGaps.h24;
                      },
                      itemCount: controller.data.length,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MessagePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MessageController>(MessageController());
  }
}
