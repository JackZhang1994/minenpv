/*
* @overview: 主题-装饰器
* @Author: rcc 
* @Date: 2024-06-06 23:26:16 
*/

part of '../index.dart';

extension AppDecorations on CustomTheme {
  BoxDecoration get input {
    return BoxDecoration(
      border: Border.all(
        color: colors.border2.withOpacity(0.5),
      ),
      borderRadius: BorderRadius.circular(50.sp),
    );
  }

  BoxDecoration get bottomBorder1 {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: colors.border1,
        ),
      ),
    );
  }

  BoxDecoration get bottomBorder3 {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 0.5,
          color: colors.border3,
        ),
      ),
    );
  }

  BoxDecoration get button1 {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(24.sp),
      color: colors.background1.withOpacity(0.15),
    );
  }

  BoxDecoration get button2 {
    return BoxDecoration(
      border: Border.all(
        width: 0.5,
        color: colors.border2.withOpacity(0.5),
      ),
      borderRadius: BorderRadius.circular(12.sp),
      color: colors.background1.withOpacity(0.15),
    );
  }

  BoxDecoration get button3 {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(60.sp),
      border: Border.all(
        width: 0.5,
        color: colors.border1,
      ),
    );
  }

  BoxDecoration get button4 {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(100.sp),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff0fcad9),
          Color(0xff36fa8f),
        ],
      ),
      border: Border.all(
        width: 0.5,
        color: colors.border1,
      ),
    );
  }

  BoxDecoration get button5 {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(100.sp),
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xff57FDB3),
          Color(0xffDFE93A),
        ],
      ),
      border: Border.all(
        width: 0.5,
        color: colors.border1,
      ),
    );
  }

  BoxDecoration get card1 {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(24.sp),
      color: colors.background1.withOpacity(0.25),
    );
  }

  BoxDecoration get card2 {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(24.sp),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          colors.background1.withOpacity(0.01),
          colors.background1.withOpacity(0),
        ],
      ),
    );
  }

  BoxDecoration get card3 {
    return BoxDecoration(
      border: Border.all(
        width: 0.5,
        color: colors.border2,
      ),
      borderRadius: BorderRadius.circular(24.sp),
      color: Color(0xff00533a),
    );
  }

  BoxDecoration get card4 {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(24.sp),
      gradient: const LinearGradient(colors: [Color(0xff88F7BF), Color(0xffE6E75C)]),
    );
  }

  BoxDecoration get card5 {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(24.sp),
      gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff0fcad9), Color(0xff36fa8f)]),
    );
  }
}
