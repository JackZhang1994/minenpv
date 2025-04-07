import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/public/404.png'), fit: BoxFit.cover),
      ),
    );
  }
}
