import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/configs/index.dart';
import 'package:yunyou_desktop/controllers/public/app_node_controller.dart';
import 'package:yunyou_desktop/models/node_model.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';
import 'package:yunyou_desktop/widgets/public/app_image.dart';

class AppNodeView extends StatelessWidget {
  const AppNodeView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppNodeController.to;
    return Expanded(
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _NodeCard(node: SubscribeNode(id: 0));
            }
            final SubscribeNode entity = (s.isProxyOnly.isTrue ? s.snodes[index - 1] : s.nodes[index - 1]);
            return _NodeCard(node: entity);
          },
          separatorBuilder: (context, index) {
            return AppGaps.h12;
          },
          itemCount: (s.isProxyOnly.isTrue ? s.nodes.length : s.snodes.length) + 1,
        ),
      ),
    );
  }
}

class _NodeCard extends StatelessWidget {
  const _NodeCard({required this.node});

  final SubscribeNode node;

  @override
  Widget build(BuildContext context) {
    final s = AppNodeController.to;
    return Obx(() {
      final isSelected = s.nodeID == node.id;
      return RcGestureDetector(
        onTap: () => AppNodeController.to.switchNode(node),
        child: Container(
          constraints: BoxConstraints(minHeight: 66.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
          ),
          child: Row(
            children: [
              _buildFlags(),
              AppGaps.w12,
              Expanded(
                child: Visibility(
                  visible: node.id != 0,
                  replacement: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '自动匹配最快网络',
                        style: AppThemes.of().medium14text1,
                      ),
                      Text(
                        '随时随刻为您选择当前最快网络连接',
                        style: AppThemes.of().medium12text3,
                      ),
                    ],
                  ),
                  child: Text(
                    node.title ?? '',
                    style: AppThemes.of().medium14text1,
                  ),
                ),
              ),
              AppGaps.w12,
              AppAssetImage.square(
                isSelected ? 'assets/images/public/app_checked.png' : 'assets/images/public/app_not_check.png',
                dimension: 20.w,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildFlags() {
    final Widget image;
    if (node.id == 0) {
      image = AppAssetImage.square(
        'assets/images/flags/app_auto_node.png',
        dimension: 42.w,
      );
    } else {
      final String flagUrl = node.icon?.isNotEmpty == true ? AppConfigs.buildImageUrl(node.icon!) : '';
      if (flagUrl.isNotEmpty) {
        image = AppImage(
          url: flagUrl,
          width: 42.w,
          height: 42.h,
          errorWidget: AppAssetImage.square('assets/images/flags/unknown.png', dimension: 42.w),
        );
      } else {
        image = AppAssetImage.square('assets/images/flags/unknown.png', dimension: 42.w);
      }
    }
    return Container(
      width: 42.w,
      height: 42.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: image,
    );
  }
}
