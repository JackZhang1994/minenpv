/*
* @overview: 
* @Author: rcc 
* @Date: 2024-02-17 16:37:39 
*/

part of rc_http;

class HttpDownload {
  HttpDownload._();

  static Future<bool> _request(DownloadOptions options) async {
    final ReceivePort receivePort = ReceivePort();
    final CancelToken cancelToken = CancelToken();

    try {
      options.sendPort.send(receivePort.sendPort);
      receivePort.listen((_) => cancelToken.cancel());

      final response = await options.dio.download(
        options.url,
        options.savePath,
        options: options.options,
        cancelToken: cancelToken,
        onReceiveProgress: (cumulative, total) {
          options.sendPort.send([cumulative, total]);
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    } finally {
      receivePort.close();
    }
  }

  static Future<bool> request({
    required Dio dio,
    required String url,
    required String savePath,
    required Options? options,
    required CancelToken? cancelToken,
    required HttpProgress? onReceiveProgress,
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
        receiveTimeout: const Duration(minutes: 10),
      );

      final DownloadOptions downloadOptions = DownloadOptions(
        dio: dio,
        url: url,
        savePath: savePath,
        sendPort: receivePort.sendPort,
        options: options ?? defaultOptions,
      );

      final result = await HttpIsolate.compute<bool, DownloadOptions>(_request, downloadOptions);

      return result;
    } catch (_) {
      return false;
    } finally {
      receivePort.close();
    }
  }
}
