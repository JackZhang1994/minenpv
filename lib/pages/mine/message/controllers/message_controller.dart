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

  int total = 0;

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

  Future<void> onRefresh() async {
    page = 1;
    await onRequestData(isRefresh: true);
  }

  Future<void> onLoadMore() async {
    await onRequestData();
  }

  Future<void> onRequestData({bool isRefresh = false}) async {
    const String url = '/api/notice/list';
    final Map<String, dynamic> params = {
      'pageSize': pageSize,
      'pageNum': page,
      'status': 0,
      'orderByColumn': 'createTime',
      'isAsc': 'desc',
    };

    final result = await RcHttp.get<MessageModel>(
      url,
      params: params,
      cancelToken: cancelToken,
      fromJson: (json) => MessageModel.fromJson(json),
      errorJson: () => MessageModel.init(),
    );

    if (result.code == 200) {
      total = result.total;
      if (isRefresh) {
        data.clear();
      }
      data.addAll(result.rows);
      page++;
      switchLoadStatus(LoadStatus.success);
    } else {
      switchLoadStatus(LoadStatus.error);
    }
  }
}
