import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

class ChannelView extends StatelessWidget {
  const ChannelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 55.h + ScreenUtil().bottomBarHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '通过社交媒体联系我们',
            style: AppThemes.of().medium14text3,
          ),
          AppGaps.h8,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildChannelView('assets/images/channel/facebook.png', ''),
              _buildChannelView('assets/images/channel/x.png', ''),
              _buildChannelView('assets/images/channel/telegram.png', ''),
              _buildChannelView('assets/images/channel/ins.png', ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChannelView(String path, String url) {
    return RcGestureDetector(
      onTap: () async {
        if (url.isNotEmpty) {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: AppAssetImage.square(path, dimension: 32.w),
      ),
    );
  }
}
