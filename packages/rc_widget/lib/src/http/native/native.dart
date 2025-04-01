/*
* @overview: 
* @Author: rcc 
* @Date: 2024-02-17 16:41:00 
*/

library rc_http;

import 'dart:isolate';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:rc_widget/rc_widget.dart';

import '../core/core.dart';

part 'http_get.dart';
part 'http_head.dart';
part 'http_post.dart';
part 'http_image.dart';
part 'http_upload.dart';
part 'http_download.dart';

class RcHttp {
  RcHttp._();

  static late final Dio _dio;

  static bool _isInit = false;

  static const String _errorText = 'RcHttp Uninitialized';

  /// HTTP初始化
  static Future<void> init({
    required BaseOptions options,
    OnError onError,
    OnRequest onRequest,
    OnResponse onResponse,
  }) async {
    _isInit = true;

    await HttpIsolate.init();

    _dio = Dio(options);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: onError,
        onRequest: onRequest,
        onResponse: onResponse,
      ),
    );
  }

  /// 设置请求地址
  static setBaseUrl(String url) {
    assert(_isInit, _errorText);

    _dio.options.baseUrl = url;
  }

  /// HEAD请求
  static Future<HttpHeadResponse> head(
    String path, {
    Options? options,
    CancelToken? cancelToken,
    bool isPrint = false,
  }) async {
    assert(RcHttp._isInit, RcHttp._errorText);

    return HttpHead.request(
      dio: _dio,
      path: path,
      options: options,
      isPrint: isPrint,
      cancelToken: cancelToken,
    );
  }

  /// GET请求
  static Future<T> get<T>(
    String path, {
    required FromJson<T> fromJson,
    required ErrorJson<T> errorJson,
    Options? options,
    CancelToken? cancelToken,
    StringMap? params,
    bool isPrint = false,
  }) async {
    assert(RcHttp._isInit, RcHttp._errorText);

    return HttpGet.request(
      dio: _dio,
      path: path,
      params: params,
      options: options,
      isPrint: isPrint,
      fromJson: fromJson,
      errorJson: errorJson,
      cancelToken: cancelToken,
    );
  }

  /// POST请求
  static Future<T> post<T>(
    String path, {
    required FromJson<T> fromJson,
    required ErrorJson<T> errorJson,
    StringMap? data,
    Options? options,
    CancelToken? cancelToken,
    bool isPrint = false,
  }) async {
    assert(RcHttp._isInit, RcHttp._errorText);

    return HttpPost.request(
      dio: _dio,
      path: path,
      data: data,
      options: options,
      isPrint: isPrint,
      fromJson: fromJson,
      errorJson: errorJson,
      cancelToken: cancelToken,
    );
  }

  /// upload上传
  static Future<T> upload<T>(
    String path, {
    required FormData data,
    required FromJson<T> fromJson,
    required ErrorJson<T> errorJson,
    Options? options,
    CancelToken? cancelToken,
    HttpProgress? onSendProgress,
    bool isPrint = false,
  }) async {
    assert(RcHttp._isInit, RcHttp._errorText);

    return HttpUpload.request(
      dio: _dio,
      path: path,
      data: data,
      options: options,
      isPrint: isPrint,
      fromJson: fromJson,
      errorJson: errorJson,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
    );
  }

  /// download下载
  static Future<bool> download(
    String url,
    String savePath, {
    Options? options,
    CancelToken? cancelToken,
    HttpProgress? onReceiveProgress,
  }) async {
    assert(RcHttp._isInit, RcHttp._errorText);

    return HttpDownload.request(
      dio: _dio,
      url: url,
      options: options,
      savePath: savePath,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// image加载
  static Future<Uint8List> image(
    String url, {
    Options? options,
    CancelToken? cancelToken,
    HttpProgress? onReceiveProgress,
  }) async {
    assert(RcHttp._isInit, RcHttp._errorText);

    return HttpImage.request(
      dio: _dio,
      url: url,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
