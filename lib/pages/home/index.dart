/*
* @overview: 首页
* @Author: rcc 
* @Date: 2024-06-08 09:37:59 
*/

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yunyou_desktop/configs/index.dart';
import 'package:yunyou_desktop/controllers/public/app_user_controller.dart';
import 'package:yunyou_desktop/utils/app_utils.dart';
import 'package:yunyou_desktop/widgets/public/app_top_bar.dart';

import '/widgets/public/app_scaffold.dart';
import '../../themes/index.dart';
import '../mine/mine_home/widgets/link_view.dart';
import '../mine/mine_home/widgets/user_view.dart';
import '../mine/mine_home/widgets/version_view.dart';
import 'controllers/home_controller.dart';
import 'widgets/app/app_icon_view.dart';
import 'widgets/app/app_status_view.dart';
import 'widgets/app/app_switch_view.dart';
import 'widgets/pc/button_view.dart';
import 'widgets/pc/renewal_view.dart';
import 'widgets/pc/switch_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  @override
  void initState() {
    if (!AppUtils.isMobile()) {
      windowManager.addListener(this);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (!AppUtils.isMobile()) {
      windowManager.removeListener(this);
    }
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
    return AdaptiveBuilder(
      defaultBuilder: (BuildContext context, Screen screen) {
        return const Placeholder();
      },
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (BuildContext context, Screen screen) {
          return Scaffold(
            appBar: AppTopBar(
              title: '${AppConfigs.appDisplayName} VPN',
              isMobile: true,
              leading: AppMenuIcon(),
            ),
            body: SizedBox.expand(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/home/home_bg.webp'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      AppSwitchView(),
                      const Spacer(),
                      AppStatusView(),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        desktop: (BuildContext context, Screen screen) {
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
        },
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
