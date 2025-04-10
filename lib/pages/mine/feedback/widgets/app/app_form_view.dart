import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

import '../../controllers/feedback_controller.dart';

class AppFormView extends GetView<FeedbackController> {
  const AppFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            controller.chooseFeedbackType();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '问题类别',
                    style: AppThemes.of().regular16text1.copyWith(color: Color(0xff6A767D)),
                  ),
                ),
                Obx(
                  () => Text(
                    controller.feedbackTypeList[controller.curFeedbackIndex.value],
                    style: AppThemes.of().regular16text2,
                  ),
                ),
                AppAssetImage.square(
                  'assets/images/public/app_arrow_right_dark_grey.png',
                  dimension: 20.w,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Row(
            children: [
              Text(
                '邮箱',
                style: AppThemes.of().regular16text1.copyWith(color: Color(0xff6A767D)),
              ),
              Expanded(
                child: TextField(
                  controller: controller.emailController,
                  cursorColor: AppThemes.of().colors.primaryColor,
                  style: AppThemes.of().regular16text1,
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    hintText: '邮箱（必填）',
                    hintStyle: AppThemes.of().regular16text4,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        AppGaps.h24,
        Container(
          width: double.infinity,
          height: 152.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: Color(0xffF6F7F9),
          ),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.descriptionController,
                  style: AppThemes.of().regular14text1,
                  decoration: InputDecoration(
                    hintText: '问题描述（必填）',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    hintStyle: AppThemes.of().regular14text4.copyWith(color: Color(0xffC1CACF)),
                  ),
                  minLines: 1,
                  maxLines: 4,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  showCursor: true,
                  cursorColor: AppThemes.of().colors.primaryColor,
                  textInputAction: TextInputAction.newline,
                  inputFormatters: <TextInputFormatter>[
                    TextInputFormatter.withFunction((TextEditingValue oldValue, TextEditingValue newValue) {
                      final TextEditingValue textEditingValue;
                      if (newValue.text.characters.length > maxDescriptionTextLength) {
                        RcToast('最多可输入$maxDescriptionTextLength字');
                        textEditingValue = newValue.replaced(
                            TextRange(start: maxDescriptionTextLength, end: newValue.text.length), '');
                      } else {
                        textEditingValue = newValue;
                      }
                      return textEditingValue;
                    })
                  ],
                ),
              ),
              Obx(
                () => Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '${controller.descriptionTextLength.value}/$maxDescriptionTextLength',
                    style: AppThemes.of().regular14text1.copyWith(color: Color(0xffBFC7CA)),
                  ),
                ),
              ),
            ],
          ),
        ),
        AppGaps.h32,
        Text(
          '照片/视频',
          style: AppThemes.of().regular16text1,
        ),
        Obx(
          () => GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: min(controller.imagesList.length + 1, maxImagesSize),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              childAspectRatio: 1,
            ),
            itemBuilder: (_, int index) {
              if (index == controller.imagesList.length && controller.imagesList.length < maxImagesSize) {
                return GestureDetector(
                  onTap: () {
                    controller.pickeImageOrVideos();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Color(0xffF6F7F9),
                    ),
                    child: AppAssetImage.square(
                      'assets/images/public/app_default_image.png',
                      dimension: 40.w,
                    ),
                  ),
                );
              } else {
                return Image.file(File(controller.imagesList[index]), fit: BoxFit.cover);
                // return AppImage(url: controller.imagesList[index]);
              }
            },
          ),
        ),
      ],
    );
  }
}
