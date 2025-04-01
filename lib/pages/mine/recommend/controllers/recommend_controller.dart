import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import '/controllers/base/app_getx_controller.dart';
import '../models/hot_app_model.dart';

class RecommendController extends AppGetxController {
  static RecommendController get to => Get.find<RecommendController>();

  final RxList<String> recommends = <String>[
    '免费加速器',
    'VIP专属节点',
    '稳定高速',
    '全球网络',
    '安全防护',
    '24小时客服',
  ].obs;

  final RxList<HotApp> hotApps = <HotApp>[].obs;

  @override
  void onInit() {
    super.onInit();
    getHotApps();
  }

  Future<void> getHotApps() async {
    const String url = '/api/hot_app/list';
    final Map<String, dynamic> params = {
      'pageSize': 20,
      'orderByColumn': 'sort',
      'isAsc': 'asc',
    };

    final result = await RcHttp.get<HotAppModel>(
      url,
      params: params,
      cancelToken: cancelToken,
      fromJson: (json) => HotAppModel.fromJson(json),
      errorJson: () => HotAppModel.init(),
    );

    if (result.code == 200) {
      hotApps.value = result.data;
    }
  }
}
