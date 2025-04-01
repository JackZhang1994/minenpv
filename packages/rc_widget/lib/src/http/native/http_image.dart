/*
* @overview: 
* @Author: rcc 
* @Date: 2024-02-17 16:37:39 
*/

part of rc_http;

class HttpImage {
  HttpImage._();

  static Future<Uint8List> _request(ImageOptions options) async {
    final ReceivePort receivePort = ReceivePort();
    final CancelToken cancelToken = CancelToken();

    try {
      options.sendPort.send(receivePort.sendPort);
      receivePort.listen((_) => cancelToken.cancel());

      final response = await options.dio.get(
        options.url,
        options: options.options,
        cancelToken: cancelToken,
        onReceiveProgress: (cumulative, total) {
          options.sendPort.send([cumulative, total]);
        },
      );

      return Uint8List.fromList(response.data);
    } catch (_) {
      rethrow;
    } finally {
      receivePort.close();
    }
  }

  static Future<Uint8List> request({
    required Dio dio,
    required String url,
    required Options? options,
    required CancelToken? cancelToken,
    required void Function(int, int)? onReceiveProgress,
  }) async {
    final ReceivePort receivePort = ReceivePort();

    try {
      receivePort.listen((message) {
        if (message is SendPort) {
          cancelToken?.whenCancel.then((_) => message.send('cancelToken'));
        }

        if (message is List) {
          onReceiveProgress?.call(message.first, message.last);
        }
      });

      final defaultOptions = Options(
        responseType: ResponseType.bytes,
        receiveTimeout: const Duration(minutes: 3),
      );

      final ImageOptions imageOptions = ImageOptions(
        dio: dio,
        url: url,
        sendPort: receivePort.sendPort,
        options: options ?? defaultOptions,
      );

      return HttpIsolate.compute<Uint8List, ImageOptions>(_request, imageOptions);
    } catch (_) {
      rethrow;
    } finally {
      receivePort.close();
    }
  }
}
