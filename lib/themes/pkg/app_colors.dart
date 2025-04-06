/*
* @overview: 主题-颜色
* @Author: rcc 
* @Date: 2024-06-06 23:25:33 
*/

part of '../index.dart';

class CustomColors {
  const CustomColors({
    required this.spinkit,
    required this.buttonText,
    required this.buttonSpinkit,
    required this.buttonBackground1,
    required this.buttonBackground2,
    required this.bottomBarText,
    required this.bottomBarTextSEL,
    required this.bottomBarBackground,
    required this.scaffoldBackground1,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.border1,
    required this.border2,
    required this.border3,
    required this.shadow1,
    required this.background1,
    required this.primaryColor,
    required this.splashColor,
    required this.highlightColor,
    required this.dividerColor,
  });

  factory CustomColors.light() {
    return const CustomColors(
      spinkit: Colors.white,
      buttonText: Colors.white,
      buttonSpinkit: Colors.white,
      buttonBackground1: Colors.white,
      buttonBackground2: Colors.white,
      bottomBarText: Colors.white,
      bottomBarTextSEL: Colors.white,
      bottomBarBackground: Colors.white,
      scaffoldBackground1: Colors.white,
      text1: Colors.white,
      text2: Color.fromARGB(255, 0, 0, 0),
      text3: Color(0xffE6E6E6),
      text4: Color(0xff6FEED2),
      text5: Color(0xffFFFC38),
      border1: Color(0xff9CF1B3),
      border2: Color(0xffFFFFFF),
      border3: Color(0xffD3D3D3),
      shadow1: Colors.white,
      background1: Color(0xFFFFFFFF),
      primaryColor: Colors.white,
      splashColor: Colors.white,
      highlightColor: Colors.white,
      dividerColor: Colors.white,
    );
  }

  factory CustomColors.dark() {
    return const CustomColors(
      spinkit: Colors.white,
      buttonText: Colors.white,
      buttonSpinkit: Colors.white,
      buttonBackground1: Colors.white,
      buttonBackground2: Colors.white,
      bottomBarText: Colors.white,
      bottomBarTextSEL: Colors.white,
      bottomBarBackground: Colors.white,
      scaffoldBackground1: Colors.white,
      text1: Colors.black,
      text2: Colors.black,
      text3: Colors.black,
      text4: Colors.black,
      text5: Colors.black,
      border1: Colors.white,
      border2: Colors.white,
      border3: Colors.white,
      shadow1: Colors.white,
      background1: Colors.white,
      primaryColor: Colors.white,
      splashColor: Colors.white,
      highlightColor: Colors.white,
      dividerColor: Colors.white,
    );
  }

  factory CustomColors.mobileLight() {
    return CustomColors(
      spinkit: Colors.white,
      buttonText: Colors.white,
      buttonSpinkit: Colors.white,
      buttonBackground1: Colors.white,
      buttonBackground2: Colors.white,
      bottomBarText: Colors.white,
      bottomBarTextSEL: Colors.white,
      bottomBarBackground: Colors.white,
      scaffoldBackground1: Colors.white,
      text1: Colors.black,
      text2: Color(0xff333333),
      text3: Color(0xff999999),
      text4: Color(0xffCCCCCC),
      text5: Colors.white,
      border1: Color(0xff9CF1B3),
      border2: Color(0xffFFFFFF),
      border3: Color(0xffD3D3D3),
      shadow1: Colors.white,
      background1: Color(0xFFFFFFFF),
      primaryColor: Color(0xff0095FF),
      splashColor: Colors.transparent,
      highlightColor: Color(0x1A0095FF),
      dividerColor: Colors.black.withOpacity(0.05),
    );
  }

  factory CustomColors.mobileDark() {
    return const CustomColors(
      spinkit: Colors.white,
      buttonText: Colors.white,
      buttonSpinkit: Colors.white,
      buttonBackground1: Colors.white,
      buttonBackground2: Colors.white,
      bottomBarText: Colors.white,
      bottomBarTextSEL: Colors.white,
      bottomBarBackground: Colors.white,
      scaffoldBackground1: Colors.white,
      text1: Colors.black,
      text2: Colors.black,
      text3: Colors.black,
      text4: Colors.black,
      text5: Colors.black,
      border1: Colors.white,
      border2: Colors.white,
      border3: Colors.white,
      shadow1: Colors.white,
      background1: Colors.white,
      primaryColor: Colors.white,
      splashColor: Colors.white,
      highlightColor: Colors.white,
      dividerColor: Colors.white,
    );
  }

  /* ------------ 基础颜色  ------------ */

  final Color primaryColor;

  final Color splashColor;

  final Color highlightColor;

  final Color dividerColor;

  /// 加载指示器
  final Color spinkit;

  /// 按钮文字
  final Color buttonText;

  /// 按钮加载指示器
  final Color buttonSpinkit;

  /// 按钮背景1
  final Color buttonBackground1;

  /// 按钮背景2
  final Color buttonBackground2;

  /// 导航文字
  final Color bottomBarText;

  /// 导航选中文字
  final Color bottomBarTextSEL;

  /// 底部导航背景色
  final Color bottomBarBackground;

  /// Scaffold背景色1
  /// light #FFFFFFFF
  final Color scaffoldBackground1;

  /* ------------ 字体颜色  ------------ */

  /// 文字颜色1
  /// light #FFFFFFFF
  final Color text1;

  /// 文字颜色2
  /// light #ff1A1A1A
  final Color text2;

  /// 文字颜色3
  /// light #ffE6E6E6
  final Color text3;

  /// 文字颜色4
  /// light #ffFC3EE4
  final Color text4;

  /// 文字颜色5
  /// light #ffFFFC38
  final Color text5;

  /* ------------ 边框颜色  ------------ */

  /// 边框颜色1
  /// light #ffDA8AF4
  final Color border1;

  /// 边框颜色2
  /// light #ffFFFFFF
  final Color border2;

  /// 边框颜色3
  /// light #ffD3D3D3
  final Color border3;

  /* ------------ 渐变颜色  ------------ */

  /// 渐变颜色1
  /// light #FFFFFFFF
  final Color shadow1;

  /* ------------ 背景颜色  ------------ */

  /// 背景色1
  /// light #FFFFFFFF
  final Color background1;
}
