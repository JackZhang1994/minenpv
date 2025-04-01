/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 12:44:01 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '/themes/index.dart';
import '/widgets/base/app_asset_image.dart';
import '/controllers/public/app_config_controller.dart';

import '../controllers/mine_home_controller.dart';

const links = [
  LinkData(
    label: '首页',
    path: '/home',
  ),
  LinkData(
    label: '节点选择',
    path: '/node',
  ),
  LinkData(
    label: '免费领取',
    path: '/invite',
  ),
  LinkData(
    label: '热门推荐',
    path: '/recommend',
  ),
  LinkData(
    label: '官方网站',
    path: '',
    isWebsite: true,
  ),
  LinkData(
    label: '在线客服',
    path: '/support',
  ),
  LinkData(
    label: '设置中心',
    path: '/setting',
  ),
];

class LinkView extends StatelessWidget {
  const LinkView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 100.h,
      shrinkWrap: true,
      itemCount: links.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: AppSpacings.h32.add(
        EdgeInsets.only(top: 48.h),
      ),
      itemBuilder: (BuildContext context, int index) {
        return _buildCard(index, links[index]);
      },
    );
  }

  Widget _buildCard(int index, LinkData data) {
    return RcGestureDetector(
      onTap: () async {
        if (data.isWebsite) {
          final website = AppConfigController.to.config.website;
          if (website?.isNotEmpty == true) {
            final uri = Uri.parse(website!);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          }
        } else if (data.path.isNotEmpty) {
          Get.toNamed(data.path);
        } else {
          MineController.to.signOut();
        }
      },
      child: Container(
        height: 100.h,
        margin: AppSpacings.b32,
        child: Row(
          children: [
            AppAssetImage.square(
              'assets/images/mine/link-$index.webp',
              dimension: 66.w,
            ),
            AppGaps.w16,
            Text(
              data.label,
              style: AppThemes.of().w400Text136,
            ),
          ],
        ),
      ),
    );
  }
}

class LinkData {
  const LinkData({
    required this.label,
    required this.path,
    this.isWebsite = false,
  });

  final String label;
  final String path;
  final bool isWebsite;
}
