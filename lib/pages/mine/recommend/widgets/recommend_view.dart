import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yunyou_desktop/configs/index.dart';

import '/themes/index.dart';
import '../controllers/recommend_controller.dart';

class RecommendView extends StatelessWidget {
  const RecommendView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppSpacings.all32,
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Column(
      children: [
        _buildHotApps(),
      ],
    );
  }

  Widget _buildHotApps() {
    final s = RecommendController.to;

    return Obx(() {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          crossAxisSpacing: 32.w,
          mainAxisSpacing: 32.h,
        ),
        itemCount: s.hotApps.length,
        itemBuilder: (context, index) {
          final app = s.hotApps[index];
          return RcGestureDetector(
            onTap: () async {
              final uri = Uri.parse(app.url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
            child: Container(
              padding: AppSpacings.all20,
              decoration: AppThemes.of().card1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (app.logo.isNotEmpty)
                    Container(
                      width: 188.w,
                      height: 188.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        AppConfigs.buildImageUrl(app.logo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  AppGaps.h8,
                  Text(
                    app.name,
                    style: AppThemes.of().w400Text132,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
