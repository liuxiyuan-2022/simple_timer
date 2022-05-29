import 'package:get/get.dart';
import 'package:simple_timer/controller/timer_controller.dart';

class TimerStatusButtonController extends GetxController {
  var stopBtnScale = 1.0.obs;
  var startBtnScale = 1.0.obs;

  // 按下<开始/暂停计时按钮>:
  void startBtnOnTapDown() {
    startBtnScale.value = 0.85;
    if (!TimerController.to.isTiming.value) {
      stopBtnScale.value = 0.85;
    }
  }

  // 松开<开始/暂停计时按钮>:
  void startBtnOnTapUp() {
    if (!TimerController.to.isTiming.value) {
      TimerController.to.startTimer();
    } else if (TimerController.to.isTiming.value &&
        !TimerController.to.isPauseTiming.value) {
      TimerController.to.pauseTimer();
    } else if (TimerController.to.isTiming.value &&
        TimerController.to.isPauseTiming.value) {
      TimerController.to.resumeTimer();
    }

    startBtnScale.value = 1;
    stopBtnScale.value = 1;
  }

  // 移开<开始/暂停计时按钮>:
  void startBtnOnTapCancel() {
    startBtnScale.value = 1;
    stopBtnScale.value = 1;
  }

  // 按下<停止计时按钮>:
  void stopBtnOnTapDown() {
    stopBtnScale.value = 0.85;
  }

  // 松开<停止计时按钮>:
  void stopBtnOnTapUp() {
    TimerController.to.stopTimer();
    stopBtnScale.value = 1;
  }

  // 移开<停止计时按钮>:
  void stopBtnOnTapCancel() {
    startBtnScale.value = 1;
    stopBtnScale.value = 1;
  }
}
