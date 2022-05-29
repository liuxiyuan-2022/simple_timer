import 'package:get/get.dart';
import 'package:simple_timer/controller/stop_watch_controller.dart';

class StopWatchStatusButtonController extends GetxController {
  // 复位/标记按钮
  var flagBtnScale = 1.0.obs;
  var startBtnScale = 1.0.obs;

  // 按下<开始/暂停计时按钮>:
  void startBtnOnTapDown() {
    startBtnScale.value = 0.85;
    if (!StopWatchController.to.isTiming.value) {
      flagBtnScale.value = 0.85;
    }
  }

  // 松开<开始/暂停计时按钮>:
  void startBtnOnTapUp() {
    if (!StopWatchController.to.isTiming.value) {
      StopWatchController.to.startTimer();
    } else if (StopWatchController.to.isTiming.value &&
        !StopWatchController.to.isPauseTiming.value) {
      StopWatchController.to.pauseTimer();
    } else if (StopWatchController.to.isTiming.value &&
        StopWatchController.to.isPauseTiming.value) {
      StopWatchController.to.resumeTimer();
    }

    startBtnScale.value = 1;
    flagBtnScale.value = 1;
  }

  // 移开<开始/暂停计时按钮>:
  void startBtnOnTapCancel() {
    startBtnScale.value = 1;
    flagBtnScale.value = 1;
  }

  // 按下<标记/复位计时按钮>:
  void flagBtnOnTapDown() {
    flagBtnScale.value = 0.85;
  }

  // 松开<标记/复位计时按钮>:
  void flagBtnOnTapUp() {
    if (StopWatchController.to.isPauseTiming.value) {
      // 复位计时
      StopWatchController.to.resetTimer();
    } else if (StopWatchController.to.isTiming.value) {
      // 标记当前时间
      StopWatchController.to.flagTimer();
    }
    flagBtnScale.value = 1;
  }

  // 移开<标记/复位计时按钮>:
  void flagBtnOnTapCancel() {
    startBtnScale.value = 1;
    flagBtnScale.value = 1;
  }
}
