/*
* @overview: 组件-二维码
* @Author: rcc 
* @Date: 2022-12-08 10:36:41 
*/

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RcQrCode extends StatelessWidget {
  const RcQrCode({
    Key? key,
    required this.data,
    this.size,
    this.margin,
    this.padding,
    this.loading = false,
    this.color = Colors.blue,
    this.background = Colors.white,
  }) : super(key: key);

  final String data;
  final Color color;
  final double? size;
  final bool loading;
  final Color background;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (loading) {
      child = Container(
        width: size,
        height: size,
        color: background,
        child: SpinKitCircle(
          size: 40.sp,
          color: color,
        ),
      );
    } else {
      child = QrImageView(
        data: data,
        padding: EdgeInsets.zero,
      );
    }

    return Container(
      width: size,
      height: size,
      margin: margin,
      padding: padding,
      color: background,
      child: child,
    );
  }
}
