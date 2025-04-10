import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/widgets/public/app_bottom_sheet.dart';

import '/controllers/base/app_getx_controller.dart';
import '../../../../models/message_model.dart';
import '../models/upload_model.dart';

const int maxDescriptionTextLength = 100;
const int maxImagesSize = 3;

class FeedbackController extends AppGetxController {
  static FeedbackController get to => Get.find<FeedbackController>();

  final ImagePicker _picker = ImagePicker();

  late TextEditingController emailController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  var feedbackTypeList = ['网络', '充值'];

  var curFeedbackIndex = 0.obs;

  var btnEnabled = false.obs;

  var descriptionTextLength = 0.obs;
  var imagesList = [].obs;
  List<String> uploadedFilePaths = [];

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_judgeBtnStatus);
    descriptionController.addListener(_descriptionControllerListener);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.removeListener(_judgeBtnStatus);
    descriptionController.removeListener(_descriptionControllerListener);
  }

  void _descriptionControllerListener() {
    descriptionTextLength.value = descriptionController.text.length;
    _judgeBtnStatus();
  }

  void _judgeBtnStatus() {
    btnEnabled.value = emailController.text.isNotEmpty && descriptionController.text.isNotEmpty;
  }

  void chooseFeedbackType() {
    Get.bottomSheet(AppBottomSheet(
      title: '问题类别',
      dataList: feedbackTypeList,
      curIndex: curFeedbackIndex.value,
      onChanged: (index) {
        curFeedbackIndex.value = index;
      },
    ));
  }

  void pickeImageOrVideos() async {
    List<XFile> pickedFileList = [];

    /// 有的平台不支持limit参数，所以此处每次只选择一个资源
    /// 且接口只支持单个文件上传
    // final int limit = maxImagesSize - imagesList.length;
    // if (limit < 2) {
    XFile? xFile = await _picker.pickMedia();
    if (xFile != null) {
      pickedFileList.add(xFile);
    }
    // } else {
    //   pickedFileList = await _picker.pickMultipleMedia(limit: limit);
    // }
    if (pickedFileList.isNotEmpty) {
      final List<String> pickedFilePathList = pickedFileList.map((item) => item.path).toList();
      imagesList.addAll(pickedFilePathList);
      EasyLoading.show(status: '上传中');
      dio.FormData formData = dio.FormData();
      for (var file in pickedFileList) {
        dio.MultipartFile multipartFile = await dio.MultipartFile.fromFile(
          file.path,
          filename: file.name,
        );
        formData.files.add(MapEntry('file', multipartFile));
      }
      final result = await RcHttp.upload(
        '/api/common/upload',
        data: formData,
        fromJson: (json) => UploadModel.fromJson(json),
        errorJson: () => UploadModel.init(),
      );
      EasyLoading.dismiss();
      if (result.code == 200) {
        RcToast('上传成功');
        uploadedFilePaths.add(result.data);
      } else {
        RcToast(result.msg);
        pickedFilePathList.forEach((item) => imagesList.remove(item));
      }
    }
  }

  void addFeedback() async {
    // TODO 接口字段需要调整
    const String url = '/api/feedback/add';
    final Map<String, dynamic> data = {
      'type': curFeedbackIndex.value,
      'email': emailController.text,
      'textContent': descriptionController.text,
      'imgContent': uploadedFilePaths.join(','),
    };
    final result = await RcHttp.post<MessageModel>(
      url,
      data: data,
      cancelToken: cancelToken,
      errorJson: () => MessageModel.init(),
      fromJson: (json) => MessageModel.fromJson(json),
    );
    if (result.code == 200) {
      RcToast('提交反馈成功');
    } else {
      RcToast(result.msg);
    }
  }
}
