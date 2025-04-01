/*
* @overview: 
* @Author: rcc 
* @Date: 2024-02-17 16:52:06 
*/

part of rc_http;

class HttpPost {
  HttpPost._();

  static Future<StringMap> _request(HttpOptions options) async {
    final ReceivePort receivePort = ReceivePort();
    final CancelToken cancelToken = CancelToken();
    final Interceptor interceptor = HttpUtils.createInterceptor(options.sendPort);

    try {
      options.dio.interceptors.add(interceptor);

      options.sendPort.send(receivePort.sendPort);
      receivePort.listen((_) => cancelToken.cancel());

      final response = await options.dio.post(
        options.path,
        data: options.data,
        options: options.options,
        cancelToken: cancelToken,
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
    required StringMap? data,
    required Options? options,
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

          httpLog.method = 'POST';
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
        data: data,
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
