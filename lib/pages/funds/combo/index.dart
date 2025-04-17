/*
* @overview: 资金-购买套餐
* @Author: rcc 
* @Date: 2024-06-09 09:22:07 
*/

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/utils/intercom_utils.dart';

import '/widgets/public/app_scaffold.dart';
import '/widgets/public/app_top_bar.dart';
import 'controllers/acombo_controller.dart';
import 'widgets/app/vip_grid_view.dart';
import 'widgets/app/vip_title_view.dart';
import 'widgets/pc/combo_view.dart';
import 'widgets/pc/tab_viwe.dart';

class ComboPage extends StatelessWidget {
  const ComboPage({super.key});

  @override
  Widget build(BuildContext context) {
    ComboController s = ComboController.to;
    return AdaptiveBuilder(
      defaultBuilder: (BuildContext context, Screen screen) {
        return const Placeholder();
      },
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (BuildContext context, Screen screen) {
          return Scaffold(
            backgroundColor: Color(0xffF8F8F8),
            appBar: AppTopBar(
              title: '会员购买',
              isMobile: true,
              // actions: RcInkWell(
              //   onTap: () {
              //     RcToast('恢复购买');
              //   },
              //   child: Text(
              //     '恢复购买',
              //     style: AppThemes.of().regular14primary,
              //   ),
              // ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(
                    () => Visibility(
                      visible: s.combo2.isNotEmpty,
                      child: Container(
                        margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.w),
                          color: Colors.white,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            VipTitleView(vipType: 2),
                            VipGridView(vipType: 2),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: s.combo1.isNotEmpty,
                      child: Container(
                        margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.w),
                          color: Colors.white,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            VipTitleView(vipType: 1),
                            VipGridView(vipType: 1),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: s.combo1.isNotEmpty || s.combo2.isNotEmpty,
                      child: Padding(
                        padding: EdgeInsets.only(top: 78.h),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            IntercomUtils.displayMessenger();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 12.h, bottom: 12.h + ScreenUtil().bottomBarHeight),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '有任何问题请直接联系',
                                    style: AppThemes.of().semibold12text1,
                                  ),
                                  WidgetSpan(child: AppGaps.w6),
                                  TextSpan(
                                    text: '在线客服',
                                    style: AppThemes.of().semibold12primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        desktop: (BuildContext context, Screen screen) {
          return const AppScaffold(
            appBar: AppTopBar(
              title: '购买套餐',
            ),
            body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabView(),
                  SizedBox(height: 20),
                  ComboView(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ComboPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ComboController>(ComboController());
  }
}
