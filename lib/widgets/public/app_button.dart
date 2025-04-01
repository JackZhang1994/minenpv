/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 21:29:19 
*/

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/themes/index.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    this.margin,
    this.disabled = false,
    this.text = '按钮',
    this.loadingText = '加载中',
    this.border = false,
  });

  final String text;
  final bool disabled;
  final String loadingText;
  final EdgeInsetsGeometry? margin;
  final bool border;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 96.h,
      margin: margin,
      decoration: border ? AppThemes.of().button3 : AppThemes.of().button4,
      child: disabled ? _buildLoading() : _buildText(),
    );
  }

  Widget _buildText() {
    return RcInkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: border
                ? AppThemes.of().w500Text432
                : AppThemes.of().w500Text132,
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loadingText.isNotEmpty)
          Flexible(
            child: Padding(
              padding: AppSpacings.r16,
              child: Text(
                loadingText,
                style: AppThemes.of().w500Text132,
              ),
            ),
          ),
        SpinKitCircle(
          size: 40.sp,
          color: AppThemes.of().colors.buttonSpinkit,
        ),
      ],
    );
  }
}
