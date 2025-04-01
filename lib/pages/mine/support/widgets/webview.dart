/*
* @overview:
* @Author: rcc
* @Date: 2024-06-09 21:45:26
*/

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../controllers/support_controller.dart';

class WebView extends StatelessWidget {
  const WebView({super.key});

  @override
  Widget build(BuildContext context) {
    final supportController = SupportController.to;
    bool isLoading = false;

    return Column(
      children: [
        Obx(
          () => supportController.progress.value < 1.0
              ? LinearProgressIndicator(
                  value: supportController.progress.value,
                  color: Color(0xff00533a),
                )
              : const SizedBox.shrink(),
        ),
        Expanded(
            child: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(supportController.initUrl)),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
          ),
          onWebViewCreated: (controller) {
            supportController.webViewController = controller;
          },
          onLoadStart: (controller, url) {
            if (!isLoading) {
              isLoading = true;
              supportController.currentUrl.value = url?.toString() ?? '';
            }
          },
          onLoadStop: (controller, url) {
            isLoading = false;
            supportController.currentUrl.value = url?.toString() ?? '';
          },
          onProgressChanged: (controller, progress) {
            supportController.progress.value = progress / 100;
          },
          onPermissionRequest: (controller, request) async {
            print("onPermissionRequest: ${request.resources}");
            return PermissionResponse(
                resources: request.resources,
                action: PermissionResponseAction.DENY);
          },
          onReceivedError: (controller, request, error) {
            // 捕获错误并更新状态
            print("onReceivedError: ${error}");
          },
        ))
      ],
    );
  }
}
