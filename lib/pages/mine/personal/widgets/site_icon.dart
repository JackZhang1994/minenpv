/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 08:57:07 
*/

import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

class SiteIcon extends StatelessWidget {
  const SiteIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return RcImageButton(
      name: 'assets/images/mine/site.webp',
      dimension: 88.w,
      imageDimension: 48.w,
      onTap: () {},
    );
  }
}
