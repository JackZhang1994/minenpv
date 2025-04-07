/*
* @overview: 主题-字体样式
* @Author: rcc 
* @Date: 2024-06-06 23:26:49 
*/

part of '../index.dart';

/// PC 字体样式
extension AppTextStyles on CustomTheme {
  TextStyle get bottomBarText {
    return TextStyle(
      fontSize: 26.sp,
      fontWeight: FontWeight.w500,
      color: colors.bottomBarText,
    );
  }

  TextStyle get bottomBarTextSEL {
    return TextStyle(
      fontSize: 26.sp,
      fontWeight: FontWeight.w500,
      color: colors.bottomBarTextSEL,
    );
  }

  TextStyle get buttonText {
    return TextStyle(
      fontSize: 30.sp,
      color: colors.buttonText,
      fontWeight: FontWeight.bold,
    );
  }

  /* ------------ w400  ------------ */

  TextStyle get w400Text148 {
    return TextStyle(
      fontSize: 48.sp,
      color: colors.text1,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get w400Text136 {
    return TextStyle(
      fontSize: 36.sp,
      color: colors.text1,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get w400Text132 {
    return TextStyle(
      fontSize: 32.sp,
      color: colors.text1,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get w400Text128 {
    return TextStyle(
      fontSize: 28.sp,
      color: colors.text1,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get w400Text124 {
    return TextStyle(
      fontSize: 24.sp,
      color: colors.text1,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get w400Text228 {
    return TextStyle(
      fontSize: 28.sp,
      color: colors.text2,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get w400Text328 {
    return TextStyle(
      fontSize: 28.sp,
      color: colors.text3,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get w400Text324 {
    return TextStyle(
      fontSize: 24.sp,
      color: colors.text3,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get w400Text320 {
    return TextStyle(
      fontSize: 20.sp,
      color: colors.text3,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get w400Text428 {
    return TextStyle(
      fontSize: 28.sp,
      color: colors.text4,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get w400Text528 {
    return TextStyle(
      fontSize: 28.sp,
      color: colors.text5,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get w400Text520 {
    return TextStyle(
      fontSize: 20.sp,
      color: colors.text5,
      fontWeight: FontWeight.w400,
    );
  }

  /* ------------ w500  ------------ */
  TextStyle get w500Text152 {
    return TextStyle(
      fontSize: 52.sp,
      color: colors.text1,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get w500Text140 {
    return TextStyle(
      fontSize: 40.sp,
      color: colors.text1,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get w500Text136 {
    return TextStyle(
      fontSize: 36.sp,
      color: colors.text1,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get w500Text132 {
    return TextStyle(
      fontSize: 32.sp,
      color: colors.text1,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get w500Text228 {
    return TextStyle(
      fontSize: 28.sp,
      color: colors.text2,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get w500Text236 {
    return TextStyle(
      fontSize: 36.sp,
      color: colors.text2,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get w500Text432 {
    return TextStyle(
      fontSize: 32.sp,
      color: colors.text4,
      fontWeight: FontWeight.w500,
    );
  }

  /* ------------ w700  ------------ */

  TextStyle get w700Text148 {
    return TextStyle(
      fontSize: 48.sp,
      color: colors.text1,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get w700Text448 {
    return TextStyle(
      fontSize: 48.sp,
      color: colors.text4,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get w700Text548 {
    return TextStyle(
      fontSize: 48.sp,
      color: colors.text5,
      fontWeight: FontWeight.bold,
    );
  }
}

/// Mobile 字体样式
extension MobileAppTextStyles on CustomTheme {
  TextStyle get regular18text1 {
    return TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: colors.text1);
  }

  TextStyle get regular14text1 {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: colors.text1);
  }

  TextStyle get regular14text3 {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: colors.text3);
  }

  TextStyle get regular14text4 {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: colors.text4);
  }

  TextStyle get regular14primary {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: colors.primaryColor);
  }

  TextStyle get regular12text1 {
    return TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: colors.text1);
  }

  TextStyle get regular12text3 {
    return TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: colors.text3);
  }

  TextStyle get regular12primary {
    return TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: colors.primaryColor);
  }

  TextStyle get medium18text1 {
    return TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: colors.text1);
  }

  TextStyle get medium16text1 {
    return TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: colors.text1);
  }

  TextStyle get medium16text5 {
    return TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: colors.text5);
  }

  TextStyle get medium16primary {
    return TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: colors.primaryColor);
  }

  TextStyle get medium14text1 {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: colors.text1);
  }

  TextStyle get medium14text3 {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: colors.text3);
  }

  TextStyle get medium14primary {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: colors.primaryColor);
  }

  TextStyle get semibold32text1 {
    return TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w600, color: colors.text1);
  }

  TextStyle get semibold20text1 {
    return TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: colors.text1);
  }

  TextStyle get semibold16text1 {
    return TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: colors.text1);
  }

  TextStyle get semibold14text3 {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: colors.text3);
  }

  TextStyle get semibold12text3 {
    return TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: colors.text3);
  }

  TextStyle get semibold10text1 {
    return TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: colors.text1);
  }
}
