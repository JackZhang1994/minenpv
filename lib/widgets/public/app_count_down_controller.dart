/*
 */
import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../controllers/base/app_getx_controller.dart';

enum EditVerificationCountDownStatus { init, running, complete }

class EditVerificationCountDownController extends AppGetxController {
  Timer? _timer;

  final status = EditVerificationCountDownStatus.init.obs;
  final RxInt _currentSecond = 0.obs;
  final int _seconds = 60;

  void start() {
    stop();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSecond.value == -1) {
        _currentSecond.value = 0;
        return;
      }
      if (_currentSecond < 1) {
        stop();
        return;
      }
      if (timer.tick >= _seconds) {
        status.value = EditVerificationCountDownStatus.complete;
        _currentSecond.value = -1;
        stop();
        return;
      }
      status.value = EditVerificationCountDownStatus.running;
      _currentSecond.value = _seconds - timer.tick;
    });
  }

  void stop() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
    _currentSecond.value = _seconds;
    _timer = null;
  }

  RxInt get currentSecond => _currentSecond;
}
