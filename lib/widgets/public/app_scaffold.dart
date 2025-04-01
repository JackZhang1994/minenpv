/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-08 09:02:08 
*/

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.drawer,
    this.showBackground = true,
  });

  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool showBackground;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: showBackground
            ? const DecorationImage(
                image: AssetImage('assets/images/public/Page_Background.png'),
                fit: BoxFit.cover,
              )
            : null,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff001d1d),
            Color(0xff001d1d),
          ],
        ),
      ),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kWindowCaptionHeight),
          child: WindowCaption(
            brightness: Brightness.dark,
            backgroundColor: Colors.transparent,
            // title: const Text('window_manager_example'),
          ),
        ),
        body: Scaffold(
          appBar: appBar,
          body: body,
          drawer: drawer,
          backgroundColor: Colors.transparent,
          bottomNavigationBar: bottomNavigationBar,
        ),
        drawer: drawer,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
