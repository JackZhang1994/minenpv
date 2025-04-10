import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/themes/index.dart';
import 'package:yunyou_desktop/widgets/base/app_asset_image.dart';

typedef OnAppBottomSheetChanged = void Function(int index);

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet(
      {super.key, required this.title, required this.dataList, this.curIndex, required this.onChanged});

  final String title;
  final List<String> dataList;
  final int? curIndex;
  final OnAppBottomSheetChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Text(
        title,
        style: AppThemes.of().semibold18text1,
      ),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Get.back();
            onChanged.call(index);
          },
          child: ListTile(
            title: Text(
              dataList[index],
              style: AppThemes.of().medium14text1,
            ),
            trailing: AppAssetImage.square(
              curIndex == index ? 'assets/images/public/app_checked.png' : 'assets/images/public/app_not_check.png',
              dimension: 20.w,
            ),
          ),
        );
      },
    );
  }
}
