import 'package:get/get.dart';

class StopWatchController extends GetxController {
  static StopWatchController get to => Get.find();
  var timerMinute = 0.obs;
  var timerSecond = 0.obs;

  // 是否正在计时
  var isTiming = false.obs;

  // 是否暂停计时
  var isPauseTiming = false.obs;

  // 开始计时
  void startTimer() {
    isTiming.value = true;

    printInfo(info: '开始');
  }

  // 暂停计时
  void pauseTimer() {
    isPauseTiming.value = true;

    printInfo(info: '暂停');
  }

  // 恢复计时
  void resumeTimer() {
    isPauseTiming.value = false;

    printInfo(info: '恢复');
  }

  // 复位计时
  void resetTimer() {
    isTiming.value = false;
    isPauseTiming.value = false;

    printInfo(info: '复位');
  }

  // 标记时间
  void flagTimer() {
    printInfo(info: '标记');
  }
}
