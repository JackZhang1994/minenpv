/*
* @overview: 
* @Author: rcc 
* @Date: 2023-03-02 14:53:52 
*/

import 'dart:isolate';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:rc_widget/rc_widget.dart';

import 'http_log.dart';

class HttpUtils {
  HttpUtils._();

  /// json格式化
  static Map<String, dynamic> fromMap(Response response) {
    if (response.data is String) {
      return json.decode(response.data);
    } else {
      return response.data ?? {};
    }
  }

  /// 创建拦截器
  static Interceptor createInterceptor(SendPort sendPort) {
    return InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        late final StringMap params;

        if (options.method == 'GET') {
          params = options.queryParameters;
        } else if (options.data is FormData) {
          params = fromFormData(options.data);
        } else if (options.data is Map) {
          params = options.data;
        } else {
          params = {};
        }

        sendPort.send(HttpRequest(
          uri: options.uri,
          params: params,
          headers: options.headers,
        ));

        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        sendPort.send(HttpResponse(response.data));

        return handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        return handler.next(error);
      },
    );
  }

  /// FormData格式化
  static StringMap fromFormData(FormData formData) {
    final StringMap map = {};

    for (final entry in formData.fields) {
      map[entry.key] = entry.value;
    }

    return map;
  }

  /// 合并日志信息
  static void mergeLog(Response response, HttpLog log) {
    final options = response.requestOptions;

    log.uri = options.uri;
    log.headers = options.headers;
    log.params =
        options.method == 'GET' ? options.queryParameters : options.data;

    log.data = response.data;
  }

  /// 打印请求信息
  static void printInfo(bool isPrint, HttpLog log) {
    if (isPrint) HttpLog.i(log);
  }

  /// 打印请求错误
  static void printError(HttpLog log, Object e, StackTrace t) {
    log.error = e;
    log.stackTrace = t;

    HttpLog.e(log);
  }
}
