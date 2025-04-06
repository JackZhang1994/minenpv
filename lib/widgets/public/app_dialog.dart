import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    this.content,
    this.negativeBtnText,
    this.positiveBtnText,
    this.onPositiveTap,
  });

  final String title;

  final String? content;

  final String? negativeBtnText;
  final String? positiveBtnText;
  final GestureTapCallback? onPositiveTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      // color: appColors.N900.withOpacity(0.55),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppGaps.h24,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  title,
                  style: AppThemes.of().medium16text1,
                  softWrap: true,
                ),
              ),
              Visibility(
                visible: content != null && content!.isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Text(
                    content ?? '',
                    style: AppThemes.of().medium14text3,
                    softWrap: true,
                  ),
                ),
              ),
              AppGaps.h16,
              Divider(),
              Row(
                children: [
                  Visibility(
                    visible: negativeBtnText != null && negativeBtnText!.isNotEmpty,
                    child: Expanded(
                      child: RcInkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 44.h,
                          child: Center(
                            child: Text(
                              negativeBtnText ?? '取消',
                              style: AppThemes.of().medium16text1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: negativeBtnText != null && negativeBtnText!.isNotEmpty,
                    child: Container(
                      width: 1.w,
                      height: 44.h,
                      color: AppThemes.of().colors.dividerColor,
                    ),
                  ),
                  Expanded(
                    child: RcInkWell(
                      onTap: () {
                        Get.back();
                        onPositiveTap?.call();
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 44.h,
                        child: Center(
                          child: Text(
                            positiveBtnText ?? '确定',
                            style: AppThemes.of().medium16primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
