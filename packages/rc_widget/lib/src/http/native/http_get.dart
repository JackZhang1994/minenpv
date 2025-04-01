/*
* @overview: 
* @Author: rcc 
* @Date: 2024-02-17 16:37:39 
*/

part of rc_http;

class HttpGet {
  HttpGet._();

  static Future<StringMap> _request(HttpOptions options) async {
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

      return HttpUtils.fromMap(response);
    } catch (e) {
      rethrow;
    } finally {
      receivePort.close();
      options.dio.interceptors.remove(interceptor);
    }
  }

  static Future<T> request<T>({
    required Dio dio,
    required String path,
    required bool isPrint,
    required Options? options,
    required StringMap? params,
    required FromJson<T> fromJson,
    required ErrorJson<T> errorJson,
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
        params: params,
        options: options,
        sendPort: receivePort.sendPort,
      );

      final json = await HttpIsolate.compute<StringMap, HttpOptions>(_request, httpOptions);
      final result = fromJson(json);

      HttpUtils.printInfo(isPrint, httpLog);

      return result;
    } catch (e, t) {
      HttpUtils.printError(httpLog, e, t);

      return errorJson();
    } finally {
      receivePort.close();
    }
  }
}
