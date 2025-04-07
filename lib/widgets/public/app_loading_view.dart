import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';

class AppLoadingView extends StatelessWidget {
  const AppLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitFadingCircle(
            color: AppThemes.of().colors.text1,
            size: 40.w,
          ),
          AppGaps.h16,
          Text(
            '加载中...',
            style: AppThemes.of().regular12text1,
          )
        ],
      ),
    );
  }
}
