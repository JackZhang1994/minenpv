/*
* @overview: App-主题配置
* @Author: rcc 
* @Date: 2024-06-06 23:24:55 
*/

library app_themes;

import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

part 'pkg/app_gaps.dart';
part 'pkg/app_colors.dart';
part 'pkg/app_spacings.dart';
part 'pkg/app_decorations.dart';
part 'pkg/app_text_styles.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get theme {
    return lightTheme;
  }

  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: CustomColors.light().scaffoldBackground1,
      extensions: [
        CustomTheme(CustomColors.light()),
      ],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      extensions: [
        CustomTheme(CustomColors.dark()),
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
