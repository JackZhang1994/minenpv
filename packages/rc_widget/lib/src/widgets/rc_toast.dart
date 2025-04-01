/*
* @overview: 组件-消息提示
* @Author: rcc 
* @Date: 2022-12-05 11:56:31 
*/

import 'package:flutter/material.dart';

class RcToast {
  RcToast(
    this.text, {
    this.theme,
    this.milliseconds = 1500,
  }) : assert(isInit, 'RcToast Uninitialized') {
    if (text.isEmpty) return;

    _overlayState = Overlay.of(callBack());
    _overlayEntry = OverlayEntry(builder: (BuildContext context) => _buildContent());
    _overlayState.insert(_overlayEntry);
    _closeToast();
  }

  static bool isInit = false;
  static late RcToastTheme globalTheme;
  static late BuildContext Function() callBack;

  final String text;
  final int milliseconds;
  final RcToastTheme? theme;

  late OverlayEntry _overlayEntry;
  late OverlayState _overlayState;

  RcToastTheme get _theme => theme ?? globalTheme;

  static void init({
    required RcToastTheme theme,
    required BuildContext Function() callBack,
  }) {
    RcToast.isInit = true;
    RcToast.callBack = callBack;
    RcToast.globalTheme = theme;
  }

  Widget _buildContent() {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: _theme.margin,
          padding: _theme.padding,
          decoration: _theme.decoration,
          child: Text(
            text,
            style: _theme.textStyle,
          ),
        ),
      ),
    );
  }

  Future<void> _closeToast() async {
    await Future.delayed(Duration(milliseconds: milliseconds));
    _overlayEntry.remove();
  }
}

class RcToastTheme {
  const RcToastTheme({
    this.margin,
    this.padding,
    this.textStyle,
    this.decoration,
  });

  factory RcToastTheme.dark() => RcToastTheme(
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 50),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      );

  factory RcToastTheme.light() => RcToastTheme(
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 50),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      );

  final TextStyle? textStyle;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
}
