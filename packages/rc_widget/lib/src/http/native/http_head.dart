/*
* @overview: 
* @Author: rcc 
* @Date: 2024-02-17 16:37:39 
*/

part of rc_http;

class HttpHead {
  HttpHead._();

  static Future<HttpHeadResponse> _request(HttpOptions options) async {
    final ReceivePort receivePort = ReceivePort();
    final CancelToken cancelToken = CancelToken();
    final Interceptor interceptor = HttpUtils.createInterceptor(options.sendPort);

    try {
      options.dio.interceptors.add(interceptor);

      options.sendPort.send(receivePort.sendPort);
      receivePort.listen((_) => cancelToken.cancel());

      final response = await options.dio.get(
        options.path,
        options: options.options,
        cancelToken: cancelToken,
        queryParameters: options.params,
      );

      final headers = response.headers;

      return HttpHeadResponse(
        type: headers.value('content-type'),
        ranges: headers.value('accept-ranges'),
        length: headers.value('content-length'),
        success: response.statusCode == 200,
      );
    } catch (e) {
      rethrow;
    } finally {
      receivePort.close();
      options.dio.interceptors.remove(interceptor);
    }
  }

  static Future<HttpHeadResponse> request({
    required Dio dio,
    required String path,
    required bool isPrint,
    required Options? options,
    required CancelToken? cancelToken,
  }) async {
    final HttpLog httpLog = HttpLog();
    final ReceivePort receivePort = ReceivePort();

    try {
      receivePort.listen((message) {
        if (message is SendPort) {
          cancelToken?.whenCancel.then((_) => message.send('cancelToken'));
        }

        if (message is HttpRequest) {
          final requestOptions = message;

          httpLog.uri = requestOptions.uri;
          httpLog.params = requestOptions.params;
          httpLog.headers = requestOptions.headers;
        }

        if (message is HttpResponse) {
          httpLog.data = message.data;
        }
      });

      final HttpOptions httpOptions = HttpOptions(
        dio: dio,
        path: path,
        options: options,
        sendPort: receivePort.sendPort,
      );

      final result = await HttpIsolate.compute<HttpHeadResponse, HttpOptions>(_request, httpOptions);

      HttpUtils.printInfo(isPrint, httpLog);

      return result;
    } catch (e, t) {
      HttpUtils.printError(httpLog, e, t);

      return HttpHeadResponse.error();
    } finally {
      receivePort.close();
    }
  }
}
