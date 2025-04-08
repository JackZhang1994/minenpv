import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'share_screenshot_controller.dart';

class ShareScreenshotView extends StatefulWidget {
  const ShareScreenshotView({
    required this.child,
    this.ratio = 1,
    this.pop,
    this.tag,
    this.isManualSavePicture = false,
    super.key,
  });

  final Widget child;
  final double ratio;
  final Function? pop;
  final String? tag;

  ///是否手动保存图片
  final bool isManualSavePicture;

  @override
  State<ShareScreenshotView> createState() => ShareScreenshotViewState();
}

class ShareScreenshotViewState extends State<ShareScreenshotView> {
  late ScreenshotController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<ScreenshotController>(tag: widget.tag);
    _controller.setRatio(widget.ratio);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        if (!widget.isManualSavePicture) {
          await _controller.savePhoto(
            saveResult: (value) {
              widget.pop?.call();
            },
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _controller,
      builder: (controller) {
        return RepaintBoundary(
          key: _controller.screenKey,
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<ScreenshotController>();
  }
}
