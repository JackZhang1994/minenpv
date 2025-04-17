/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-10 22:17:59 
*/

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yunyou_desktop/utils/app_utils.dart';
import 'package:yunyou_desktop/widgets/public/app_dialog.dart';

import '/controllers/base/app_getx_controller.dart';
import '/controllers/public/app_user_controller.dart';
import '/models/message_model.dart';
import '/pages/funds/pay_code/models/pay_model.dart';
import '../models/combo_model.dart';
import '../models/create_order_model.dart';
import '../widgets/pc/pay_view.dart';

class ComboController extends AppSuperGetxController {
  static ComboController get to => Get.find<ComboController>();

  final RxInt tabIndex = 0.obs;

  final RxList<Shop> combo1 = RxList();
  final RxList<Shop> combo2 = RxList();

  List<Shop> get combos {
    if (tabIndex.value == 0) {
      return combo1;
    } else {
      return combo2;
    }
  }

  final Map<int, String> durationMap = {
    7: '1周',
    30: '1个月',
    90: '3个月',
    365: '12个月',
  };

  bool _launchPayUrl = false;

  @override
  void onInit() {
    super.onInit();

    getCombo();
    // 更新余额
    AppUserController.to.getUser();
  }

  @override
  void onResumed() {
    super.onResumed();
    if (_launchPayUrl && AppUtils.isMobile()) {
      Get.dialog(
        AppDialog(
          title: '已完成支付？',
          negativeBtnText: '放弃支付',
          positiveBtnText: '确定',
          onPositiveTap: () {
            AppUserController.to.getUser();
          },
        ),
      );
      _launchPayUrl = false;
    }
  }

  void onTabChange(int index) {
    tabIndex.value = index;
  }

  // 获取套餐
  Future<void> getCombo() async {
    EasyLoading.show(status: '加载中');
    await Future.wait([getVipCombo(), getSvipCombo()]);
    EasyLoading.dismiss();
  }

  Future<void> getVipCombo() async {
    final Map<String, dynamic> data = {
      "vipType": 1,
    };
    const String url = '/api/payment/vip';
    final result = await RcHttp.get<ComboModel>(
      url,
      params: data,
      cancelToken: cancelToken,
      errorJson: () => ComboModel.init(),
      fromJson: (json) => ComboModel.fromJson(json),
    );

    if (result.code == 200) {
      combo1.value = result.data;
      combo1.sort((shop1, shop2) {
        if (shop1.endTime != null && shop2.endTime == null) {
          return -1;
        } else if (shop1.endTime == null && shop2.endTime != null) {
          return 1;
        } else {
          final shop1Duration = shop1.vipDuration ?? -1;
          final shop2Duration = shop2.vipDuration ?? -1;
          return shop2Duration.compareTo(shop1Duration);
        }
      });
    }
  }

  Future<void> getSvipCombo() async {
    final Map<String, dynamic> data = {
      "vipType": 2,
    };
    const String url = '/api/payment/vip';
    final result = await RcHttp.get<ComboModel>(
      url,
      params: data,
      cancelToken: cancelToken,
      errorJson: () => ComboModel.init(),
      fromJson: (json) => ComboModel.fromJson(json),
    );

    if (result.code == 200) {
      combo2.value = result.data;
      combo2.sort((shop1, shop2) {
        if (shop1.endTime != null && shop2.endTime == null) {
          return -1;
        } else if (shop1.endTime == null && shop2.endTime != null) {
          return 1;
        } else {
          final shop1Duration = shop1.vipDuration ?? -1;
          final shop2Duration = shop2.vipDuration ?? -1;
          return shop2Duration.compareTo(shop1Duration);
        }
      });
    }
  }

  /// 下单
  Future<void> placeOrder(Shop value) async {
    final price = value.price!;
    final balance = double.parse(AppUserController.to.balance);

    if (balance < price) {
      if (AppUtils.isMobile()) {
        mobilePay(value);
      } else {
        await openPopup(value);
      }
    } else {
      await balancePurchase(value);
    }
  }

  /// 余额购买
  Future<void> balancePurchase(Shop value) async {
    EasyLoading.show(status: '支付中', dismissOnTap: true);

    const String url = '/user/buy';

    final Map<String, dynamic> data = {
      'shop': value.id,
    };

    final result = await RcHttp.post<MessageModel>(
      url,
      data: data,
      cancelToken: cancelToken,
      errorJson: () => MessageModel.init(),
      fromJson: (json) => MessageModel.fromJson(json),
    );

    RcToast(result.msg);
    if (result.code == 200) {
      AppUserController.to.getUser();
    }

    EasyLoading.dismiss(animation: false);
  }

  Future<void> mobilePay(Shop shop) async {
    EasyLoading.show(status: '创建订单中', dismissOnTap: true);

    const String url = '/api/order/create';

    Map<String, dynamic> data = {
      'channelId': 3,
      'vipId': shop.id ?? 0,
    };

    final result = await RcHttp.post<CreateOrderModel>(
      url,
      data: data,
      cancelToken: cancelToken,
      errorJson: () => CreateOrderModel.init(),
      fromJson: (json) => CreateOrderModel.fromJson(json),
    );

    if (result.code == 200) {
      final String url = Uri.decodeFull(result.data.payUrl);
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        _launchPayUrl = true;
      }
    } else {
      RcToast('创建订单失败');
    }

    EasyLoading.dismiss(animation: false);
  }

  /// 支付类型弹窗
  Future<void> openPopup(Shop value) async {
    showDialog(
      context: Get.overlayContext!,
      builder: (_) {
        return PayView((type) {
          Get.back();

          countPrice(value, type);
        });
      },
    );
  }

  /// 计算支付价格
  Future<void> countPrice(Shop value, int type) async {
    payPurchase(
      channelId: type,
      vipId: value.id!,
    );
  }

  /// 支付购买
  Future<void> payPurchase({
    required int vipId,
    required int channelId,
  }) async {
    const String url = '/api/order/create';

    final Map<String, dynamic> data = {
      'channelId': channelId,
      'vipId': vipId,
    };

    final result = await RcHttp.post<PayModel>(
      url,
      data: data,
      cancelToken: cancelToken,
      errorJson: () => PayModel.init(),
      fromJson: (json) => PayModel.fromJson(json),
    );

    if (result.code == 200) {
      Get.toNamed('/pay_code', arguments: {'url': result.data!, "channelId": channelId});
    } else {
      RcToast('支付失败');
    }

    EasyLoading.dismiss(animation: false);
  }

  /// 将套餐天数转换为套餐时长
  String convertDaysToDuration(int days) {
    if (days < 7) {
      return '$days天';
    }
    for (final key in durationMap.keys.toList()..sort()) {
      if (days <= key) {
        return durationMap[key]!;
      }
    }
    int nums = days ~/ 30;
    return '$nums个月';
  }

  /// 计算折扣比例
  String calcDiscountValue(double price, double oldPrice, int days) {
    if (price == 0 || oldPrice == 0) {
      return '';
    }
    final int discount = ((1 - price / oldPrice) * 100).roundToDouble().toInt();
    return '-$discount%';
  }

  /// 计算每日单价
  String calcDailyPrice(double price, int days) {
    return (price / days).toStringAsFixed(2);
  }
}
