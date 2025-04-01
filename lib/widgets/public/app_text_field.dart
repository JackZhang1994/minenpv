/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 21:21:56 
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/themes/index.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.hintText,
    this.style,
    this.hintStyle,
    this.controller,
    this.contentPadding,
    this.inputFormatters,
    this.obscureText = false,
  });

  final String? hintText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool obscureText;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      cursorColor: Colors.white,
      style: AppThemes.of().w400Text128,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        border: InputBorder.none,
        contentPadding: contentPadding,
        hintStyle: hintStyle ?? AppThemes.of().w400Text328,
      ),
    );
  }
}
