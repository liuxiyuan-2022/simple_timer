import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchController extends GetxController {
  static StopWatchController get to => Get.find();

  // 计时控制器
  var stopWatchTimer = StopWatchTimer();

  var timerMinute = 0.obs;
  var timerSecond = 0.obs;
  var timerMillSecond = 0.obs;

  // 是否正在计时
  var isTiming = false.obs;

  // 是否暂停计时
  var isPauseTiming = false.obs;

  // 开始计时
  void startTimer() {
    late int _timerSecond;
    late int _timerMinute;

    isTiming.value = true;
    // 创建计时器控制器
    stopWatchTimer = StopWatchTimer(
      onChange: (v) {
        timerMillSecond.value =
            int.parse(StopWatchTimer.getDisplayTimeMillisecond(v));
        _timerSecond = int.parse(StopWatchTimer.getDisplayTimeSecond(v));
        _timerMinute = int.parse(StopWatchTimer.getDisplayTimeMinute(v));
      },
      onChangeRawSecond: (v) {
        timerSecond.value = _timerSecond;
        timerMinute.value = _timerMinute;
      },

      // 计时停止时调用:
      onEnded: () {
        resetTimer();
        printInfo(info: '计时停止');
      },
    );
    stopWatchTimer.onExecute.add(StopWatchExecute.start); // 启动计时器
    printInfo(info: '开始');
  }

  // 暂停计时
  void pauseTimer() {
    isPauseTiming.value = true;
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    printInfo(info: '暂停');
  }

  // 恢复计时
  void resumeTimer() {
    isPauseTiming.value = false;
    stopWatchTimer.onExecute.add(StopWatchExecute.start);
    printInfo(info: '恢复');
  }

  // 复位计时
  void resetTimer() {
    isTiming.value = false;
    isPauseTiming.value = false;

    timerMillSecond.value = 0;
    timerSecond.value = 0;
    timerMinute.value = 0;
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    printInfo(info: '复位');
  }

  // 标记时间
  void flagTimer() {
    printInfo(info: '标记');
  }
}
