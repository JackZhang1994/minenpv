import 'package:flutter/cupertino.dart';

class MenuEntity {
  final String imgPath;
  final String title;
  final GestureTapCallback onTap;

  MenuEntity({
    required this.imgPath,
    required this.title,
    required this.onTap,
  });
}
