/*
* @overview: 
* @Author: rcc 
* @Date: 2023-03-02 14:38:43 
*/

import 'dart:isolate';

import 'package:dio/dio.dart';

typedef ErrorJson<T> = T Function();
typedef StringMap = Map<String, dynamic>;
typedef FromJson<T> = T Function(StringMap json);
typedef HttpProgress = void Function(int, int);
typedef OnError = void Function(DioException error, ErrorInterceptorHandler handler)?;
typedef OnRequest = void Function(RequestOptions options, RequestInterceptorHandler handler)?;
typedef OnResponse = void Function(Response<dynamic> response, ResponseInterceptorHandler handler)?;

class HttpOptions {
  HttpOptions({
    required this.dio,
    required this.path,
    required this.options,
    required this.sendPort,
    this.data,
    this.params,
  });

  final Dio dio;
  final String path;
  final SendPort sendPort;

  final Object? data;
  final Options? options;
  final StringMap? params;
}

class ImageOptions {
  ImageOptions({
    required this.dio,
    required this.url,
    required this.sendPort,
    this.options,
  });

  final Dio dio;
  final String url;
  final SendPort sendPort;

  final Options? options;
}

class DownloadOptions {
  DownloadOptions({
    required this.dio,
    required this.url,
    required this.savePath,
    required this.sendPort,
    this.options,
  });

  final Dio dio;
  final String url;
  final String savePath;
  final SendPort sendPort;

  final Options? options;
}

class HttpRequest {
  const HttpRequest({
    required this.uri,
    required this.params,
    required this.headers,
  });

  final Uri uri;
  final StringMap params;
  final StringMap headers;
}

class HttpResponse {
  const HttpResponse(this.data);

  final dynamic data;
}

class HttpHeadResponse {
  HttpHeadResponse({
    this.type,
    this.ranges,
    this.length,
    this.success = false,
  });

  factory HttpHeadResponse.error() => HttpHeadResponse();

  /// content-type
  final String? type;

  /// accept-ranges
  final String? ranges;

  /// content-length
  final String? length;

  /// 请求是否成功
  final bool success;
}
