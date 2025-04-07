/*
* @overview: 
* @Author: rcc 
* @Date: 2024-06-09 18:12:44 
*/

import 'dart:isolate';

import 'package:rc_widget/rc_widget.dart';

import '/configs/index.dart';

class HttpConfigs {
  const HttpConfigs._();

  static final BaseOptions options = BaseOptions(
    baseUrl: AppConfigs.apiUrl,
    headers: {'Accept': 'application/json'},
    sendTimeout: const Duration(minutes: 5),
    connectTimeout: const Duration(minutes: 5),
    receiveTimeout: const Duration(minutes: 10),
    validateStatus: (statusCode) {
      final codes = [100, 200, 400, 405, 500];

      return codes.contains(statusCode);
    },
  );

  static OnRequest onRequest() {
    final ReceivePort rootReceivePort = ReceivePort();
    final SendPort rootSendPort = rootReceivePort.sendPort;

    rootReceivePort.listen((message) async {
      final SendPort sendPort = message;

      // 获取 token
      final superId = await RcStorage.getString(RcStorageKey.superId);

      final token = await RcStorage.getString(RcStorageKey.token);

      sendPort.send({RcStorageKey.superId: superId, RcStorageKey.token: token});
    });

    return (options, handler) async {
      final ReceivePort receivePort = ReceivePort();

      rootSendPort.send(receivePort.sendPort);

      final Map<String, String> data = await receivePort.first;

      final String superId = data[RcStorageKey.superId] ?? '-1';
      // final String token = data[RcStorageKey.token] ?? '';
      final String token = 'Bearer a836fada-c162-4b19-b1a6-68136dd2a578';

      options.headers.addAll({
        'Authorization': "Bearer $token",
      });

      if (options.method.toUpperCase() == 'GET') {
        options.queryParameters.addAll({
          'superId': superId,
        });
      } else {
        if (options.data is Map<String, dynamic>) {
          options.data.addAll({
            'superId': superId,
          });
        } else {
          options.data ??= {'superId': superId};
        }
      }

      print("====== HTTP Request Log Start ======");
      print("Request URL: ${options.uri}");
      print("Request Method: ${options.method}");
      print("Request Headers: ${options.headers}");
      print("Request Body: ${options.data}");
      print("====== HTTP Request Log End ======");

      handler.next(options);
    };
  }

  static OnResponse onResponse() {
    return (response, handler) {
      // 添加日志打印
      print("====== HTTP Response Log Start ======");
      print("Response URL: ${response.requestOptions.uri}");
      print("Response Status Code: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      print("Response Data: ${response.data}");
      print("====== HTTP Response Log End ======");

      handler.next(response);
    };
  }
}
