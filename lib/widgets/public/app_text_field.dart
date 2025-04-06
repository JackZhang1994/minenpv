/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 21:21:56 
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/utils/app_utils.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

import '/themes/index.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.hintText,
    this.style,
    this.hintStyle,
    this.controller,
    this.contentPadding,
    this.inputFormatters,
    this.obscureText = false,
    this.keyboardType,
  });

  final String? hintText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool obscureText;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    if (AppUtils.isMobile()) {
      return TextField(
        obscureText: _obscureText,
        controller: widget.controller,
        cursorColor: AppThemes.of().colors.primaryColor,
        style: AppThemes.of().regular14text1,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.hintText,
          contentPadding: widget.contentPadding,
          hintStyle: widget.hintStyle ?? AppThemes.of().regular14text4,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppThemes.of().colors.text1, width: 1.h),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppThemes.of().colors.text1, width: 1.h),
          ),
          suffixIcon: widget.keyboardType == TextInputType.visiblePassword ? _buildEyesBtn() : null,
          suffixIconConstraints:
              widget.keyboardType == TextInputType.visiblePassword ? BoxConstraints.tight(Size(16.w, 16.w)) : null,
        ),
      );
    } else {
      return TextField(
        obscureText: widget.obscureText,
        controller: widget.controller,
        cursorColor: Colors.white,
        style: AppThemes.of().w400Text128,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.hintText,
          border: InputBorder.none,
          contentPadding: widget.contentPadding,
          hintStyle: widget.hintStyle ?? AppThemes.of().w400Text328,
        ),
      );
    }
  }

  Widget _buildEyesBtn() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: AppAssetImage.square(
        _obscureText ? 'assets/images/public/app_eye_opened.png' : 'assets/images/public/app_eye_closed.png',
        dimension: 16.w,
      ),
    );
  }
}
