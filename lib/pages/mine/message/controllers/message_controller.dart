import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';

import '/controllers/base/app_getx_controller.dart';
import '../models/message_model.dart';

class MessageController extends AppGetxController {
  static MessageController get to => Get.find<MessageController>();

  late EasyRefreshController refreshController = EasyRefreshController();

  var data = List<MessageEntity>.empty(growable: true).obs;

  List<MessageEntity> get fakeList => List<MessageEntity>.filled(pageSize, MessageEntity.init());

  final int pageSize = 10;

  int page = 1;

  @override
  void onInit() {
    super.onInit();
    data.addAll(fakeList);
    onRefresh();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  void onRefresh() {
    page = 1;
    onRequestData(isRefresh: true);
  }

  void onLoadMore() {
    onRequestData();
  }

  void onRequestData({bool isRefresh = false}) async {
    const String url = '/api/hot_app/list';
    final Map<String, dynamic> params = {
      'pageSize': pageSize,
      'pageNum': page,
    };

    final result = await RcHttp.get<MessageModel>(
      url,
      params: params,
      cancelToken: cancelToken,
      fromJson: (json) => MessageModel.fromJson(json),
      errorJson: () => MessageModel.init(),
    );

    if (result.code == 200) {
      if (isRefresh) {
        data.clear();
      }
      data.addAll(result.data);
      page++;
      switchLoadStatus(LoadStatus.success);
    } else {
      switchLoadStatus(LoadStatus.error);
    }
  }
}
