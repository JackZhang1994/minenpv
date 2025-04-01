/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 11:55:42 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

class ServiceIcon extends StatelessWidget {
  const ServiceIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return RcImageButton(
      name: 'assets/images/public/earphone.webp',
      dimension: 88.w,
      imageDimension: 48.w,
      onTap: () => Get.toNamed('/support'),
    );
  }
}
