import 'dart:ffi';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchController extends GetxController {
  static StopWatchController get to => Get.find();

  late SharedPreferences prefs;

  // 计时控制器
  var stopWatchTimer = StopWatchTimer();

  var timerMinute = 0.obs;
  var timerSecond = 0.obs;
  var timerMillSecond = 0.obs;

  /// 是否正在计时
  var isTiming = false.obs;

  /// 是否暂停计时
  var isPauseTiming = false.obs;

  /// 单圈时间列表
  var lapTimeList = <String>[].obs;

  /// 单圈时间间隔列表
  var lapIntervalList = <String>[].obs;

  /// 单圈计时序号
  var lapIndex = 0;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    initLapTimeList();
  }

  /// 开始计时
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
    );
    stopWatchTimer.onExecute.add(StopWatchExecute.start); // 启动计时器
  }

  /// 暂停计时
  void pauseTimer() {
    isPauseTiming.value = true;
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  /// 恢复计时
  void resumeTimer() {
    isPauseTiming.value = false;
    stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  /// 复位计时
  void resetTimer() async {
    isTiming.value = false;
    isPauseTiming.value = false;
    stopWatchTimer.onExecute.add(StopWatchExecute.reset);

    lapTimeList.clear();
    lapIntervalList.clear();
    lapIndex = 0;
    await prefs.setStringList('lapTimeList', []);
    await prefs.setStringList('lapIntervalList', []);
    await prefs.setInt('lapIndex', 0);
  }

  /// 记录单圈时间
  void recordLapTime() async {
    lapIndex++;
    String lapTime =
        '${timerMinute.toString().padLeft(2, '0')}:${timerSecond.toString().padLeft(2, '0')}.${timerMillSecond.toString().padLeft(2, '0')}';

    stopWatchTimer.onExecute.add(StopWatchExecute.lap);
    lapTimeList.add(lapTime);
    countLapInterval();
    lapTimeList.value = lapTimeList.reversed.toList();
    lapIntervalList.value = lapIntervalList.reversed.toList();

    await prefs.setStringList('lapTimeList', lapTimeList);
    await prefs.setStringList('lapIntervalList', lapIntervalList);
    await prefs.setInt('lapIndex', lapIndex);
  }

  /// 初始化单圈时间列表
  void initLapTimeList() {
    lapIndex = 0;
    lapTimeList.value = prefs.getStringList('lapTimeList') ?? [];
    lapIntervalList.value = prefs.getStringList('lapIntervalList') ?? [];
    lapIndex = prefs.getInt('lapIndex') ?? 0;
  }

  /// 记录单圈时间间隔
  void countLapInterval() {
    if (lapTimeList.length == 1) {
      lapIntervalList.add('+00:00.00');
    } else {
      int lastLapTime =
          int.parse(lapTimeList[lapIndex - 1].substring(0, 2)) * 60 * 1000 +
              int.parse(lapTimeList[lapIndex - 1].substring(3, 5)) * 1000 +
              int.parse(lapTimeList[lapIndex - 1].substring(6, 8));

      int nowLapTime =
          int.parse(lapTimeList[lapIndex].substring(0, 2)) * 60 * 1000 +
              int.parse(lapTimeList[lapIndex].substring(3, 5)) * 1000 +
              int.parse(lapTimeList[lapIndex].substring(6, 8));

      int _lapInterval = nowLapTime - lastLapTime;
      formatTime(_lapInterval);
    }
  }

  /// 将毫秒转化为 分/秒/毫秒
  void formatTime(int time) {}

  @override
  void onClose() {
    super.onClose();
    stopWatchTimer.dispose();
  }
}
