/*
* @overview: App-主题配置
* @Author: rcc 
* @Date: 2024-06-06 23:24:55 
*/

library app_themes;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/utils/app_utils.dart';

part 'pkg/app_colors.dart';
part 'pkg/app_decorations.dart';
part 'pkg/app_gaps.dart';
part 'pkg/app_spacings.dart';
part 'pkg/app_text_styles.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get theme {
    return lightTheme;
  }

  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      primaryColor: AppUtils.isMobile() ? CustomColors.mobileLight().primaryColor : CustomColors.light().primaryColor,
      scaffoldBackgroundColor: AppUtils.isMobile()
          ? CustomColors.mobileLight().scaffoldBackground1
          : CustomColors.light().scaffoldBackground1,
      splashColor: AppUtils.isMobile() ? CustomColors.mobileLight().splashColor : CustomColors.light().splashColor,
      highlightColor:
          AppUtils.isMobile() ? CustomColors.mobileLight().highlightColor : CustomColors.light().highlightColor,
      dividerColor: AppUtils.isMobile() ? CustomColors.mobileLight().dividerColor : CustomColors.light().dividerColor,
      dividerTheme: DividerThemeData(
        color: AppUtils.isMobile() ? CustomColors.mobileLight().dividerColor : CustomColors.light().dividerColor,
        thickness: 1.h,
        space: 0,
      ),
      extensions: [
        CustomTheme(AppUtils.isMobile() ? CustomColors.mobileLight() : CustomColors.light()),
      ],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: CustomColors.dark().primaryColor,
      extensions: [
        CustomTheme(AppUtils.isMobile() ? CustomColors.mobileDark() : CustomColors.dark()),
      ],
    );
  }

  static CustomTheme of([BuildContext? context]) {
    return Theme.of(context ?? Get.context!).extension<CustomTheme>()!;
  }
}

class CustomTheme extends ThemeExtension<CustomTheme> {
  const CustomTheme(this.colors);

  final CustomColors colors;

  @override
  ThemeExtension<CustomTheme> copyWith() => this;

  @override
  ThemeExtension<CustomTheme> lerp(covariant ThemeExtension<CustomTheme>? other, double t) => this;
}
