/*
* @overview: http配置
* @Author: rcc 
* @Date: 2022-12-03 15:11:14 
*/

import 'dart:typed_data';
import 'package:dio/dio.dart';

import '../core/core.dart';

class RcHttp {
  RcHttp._();

  static late Dio _dio;

  static bool _isInit = false;

  static const String _errorText = 'RcHttp Uninitialized';

  /// HTTP初始化
  static void init({
    required BaseOptions options,
    OnError onError,
    OnRequest onRequest,
    OnResponse onResponse,
  }) async {
    _isInit = true;

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

  /// get请求
  static Future<T> get<T>(
    String path, {
    required FromJson<T> fromJson,
    required ErrorJson<T> errorJson,
    Options? options,
    StringMap? params,
    CancelToken? cancelToken,
    bool isPrint = false,
  }) async {
    assert(_isInit, _errorText);

    final HttpLog httpLog = HttpLog();

    try {
      final response = await _dio.get(
        path,
        options: options,
        queryParameters: params,
        cancelToken: cancelToken,
      );

      final json = HttpUtils.fromMap(response);
      final result = fromJson(json);

      HttpUtils.mergeLog(response, httpLog);
      HttpUtils.printInfo(isPrint, httpLog);

      return result;
    } catch (e, t) {
      HttpUtils.printError(httpLog, e, t);

      return errorJson();
    }
  }

  /// post请求
  static Future<T> post<T>(
    String path, {
    required FromJson<T> fromJson,
    required ErrorJson<T> errorJson,
    StringMap? data,
    Options? options,
    CancelToken? cancelToken,
    bool isPrint = false,
  }) async {
    assert(_isInit, _errorText);

    final HttpLog httpLog = HttpLog();

    try {
      final response = await _dio.post(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );

      final json = HttpUtils.fromMap(response);
      final result = fromJson(json);

      HttpUtils.mergeLog(response, httpLog);
      HttpUtils.printInfo(isPrint, httpLog);

      return result;
    } catch (e, t) {
      HttpUtils.printError(httpLog, e, t);

      return errorJson();
    }
  }

  /// upload上传
  static Future<T> upload<T>(
    String path, {
    required FromJson<T> fromJson,
    required ErrorJson<T> errorJson,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
    HttpProgress? onSendProgress,
    bool isPrint = false,
  }) async {
    assert(_isInit, _errorText);

    final HttpLog httpLog = HttpLog();

    try {
      final defaultOptions = Options(
        sendTimeout: const Duration(minutes: 10),
      );

      final response = await _dio.post(
        path,
        data: data,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        options: options ?? defaultOptions,
      );

      final json = HttpUtils.fromMap(response);
      final result = fromJson(json);

      HttpUtils.mergeLog(response, httpLog);
      HttpUtils.printInfo(isPrint, httpLog);

      return result;
    } catch (e, t) {
      HttpUtils.printError(httpLog, e, t);

      return errorJson();
    }
  }

  /// 图片加载
  static Future<Uint8List> image(
    String path, {
    Options? options,
    CancelToken? cancelToken,
    HttpProgress? onReceiveProgress,
  }) async {
    assert(_isInit, _errorText);

    try {
      final defaultOptions = Options(
        responseType: ResponseType.bytes,
        receiveTimeout: const Duration(minutes: 3),
      );

      final response = await _dio.get<List<int>>(
        path,
        cancelToken: cancelToken,
        options: options ?? defaultOptions,
        onReceiveProgress: onReceiveProgress,
      );

      return Uint8List.fromList(response.data!);
    } catch (_) {
      rethrow;
    }
  }

  /// 文件下载
  static Future<bool> download(
    String urlPath,
    String savePath, {
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    assert(_isInit, _errorText);

    try {
      final defaultOptions = Options(
        receiveTimeout: const Duration(minutes: 10),
      );

      final response = await _dio.download(
        urlPath,
        savePath,
        cancelToken: cancelToken,
        options: options ?? defaultOptions,
        onReceiveProgress: onReceiveProgress,
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
