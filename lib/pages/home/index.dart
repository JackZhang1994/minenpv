/*
* @overview: 首页
* @Author: rcc 
* @Date: 2024-06-08 09:37:59 
*/

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yunyou_desktop/configs/index.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';

import '../../themes/index.dart';
import '../mine/mine_home/widgets/link_view.dart';
import '../mine/mine_home/widgets/user_view.dart';
import '../mine/mine_home/widgets/version_view.dart';
import '/widgets/public/app_scaffold.dart';

import 'widgets/button_view.dart';
import 'widgets/switch_view.dart';
import 'widgets/renewal_view.dart';
import 'controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  @override
  void initState() {
    // TODO: implement initState
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    // TODO: implement dispose
    super.dispose();
  }

  int _selectedIndex = 0;

  bool extended = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      AppUserController.to.getUser();
      debugPrint('in is prvent close');
      windowManager.hide();
      // showDialog(
      //   context: context,
      //   builder: (_) {
      //     return AlertDialog(
      //       title: Text('Are you sure you want to close this window?'),
      //       actions: [
      //         TextButton(
      //           child: Text('No'),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //         TextButton(
      //           child: Text('Yes'),
      //           onPressed: () async {
      //             Navigator.of(context).pop();
      //             await windowManager.destroy();
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      // appBar: const AppTopBar(
      //   title: '秒连VPN',
      //   leading: MenuIcon(),
      //   actions: ServiceIcon(),
      // ),
      body: Row(
        children: [
          Container(
            width: 220,
            color: Color(0xff001d1d),
            child: Column(
              children: [
                // const SidebarLogo(),
                const UserView(),
                const LinkView(),
                Expanded(child: Container()),
                const RenewalView(),
                const VersionView(),
              ],
            ),
          ),
          // const VerticalDivider(thickness: 0, width: 0),
          const Expanded(
            child: Column(
              children: [
                SwitchView(),
                ButtonView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(), tag: RcTag.tag);
  }
}

class SidebarLogo extends StatelessWidget {
  const SidebarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacings.v32,
      margin: AppSpacings.h32,
      child: Row(
        children: [
          Image.asset(
            'assets/images/public/logo_desktop.png',
            width: 33.w,
            height: 33.h,
          ),
          SizedBox(width: 10.w),
          Text(
            AppConfigs.appDisplayName,
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
