/*
* @overview: 工具-多线程
* @Author: rcc 
* @Date: 2023-02-09 13:59:45 
*/

import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';

typedef ComputeFunction<T, R> = FutureOr<T> Function(R);

class HttpIsolate {
  HttpIsolate._();

  static late Isolate _isolate;
  static late SendPort _sendPort;

  static Future<void> init() async {
    final ReceivePort receivePort = ReceivePort();
    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;

    _isolate = await Isolate.spawn(
      _run,
      [
        receivePort.sendPort,
        rootIsolateToken,
      ],
      debugName: 'RcHttpIsolate',
    );

    _sendPort = await receivePort.first;
    receivePort.close();
  }

  static void _run(List arguments) {
    final ReceivePort receivePort = ReceivePort();

    arguments.first.send(receivePort.sendPort);
    BackgroundIsolateBinaryMessenger.ensureInitialized(arguments.last);

    receivePort.listen((messages) async {
      final SendPort replyPort = messages[0];

      try {
        final callBack = messages[1];
        final argument = messages[2];

        final result = await callBack(argument);

        replyPort.send([result]);
      } catch (e, t) {
        replyPort.send([e.toString(), t.toString()]);
      }
    });
  }

  static Future<T> compute<T, R>(ComputeFunction<T, R> function, [R? argument]) async {
    final Completer<T> completer = Completer<T>();
    final RawReceivePort receivePort = RawReceivePort();

    _computeFuture<T>(
      completer: completer,
      receivePort: receivePort,
    );

    _sendPort.send([receivePort.sendPort, function, argument]);

    return completer.future;
  }

  static Future<void> _computeFuture<T>({
    required Completer<T> completer,
    required RawReceivePort receivePort,
  }) async {
    receivePort.handler = (List result) {
      if (result.length == 1) {
        completer.complete(result.first as T);
      } else {
        completer.completeError(result.first, StackTrace.fromString(result.last));
      }

      receivePort.close();
    };
  }

  static void kill() {
    _isolate.kill();
  }
}
