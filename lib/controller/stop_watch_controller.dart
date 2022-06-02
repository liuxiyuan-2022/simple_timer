import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchController extends GetxController {
  static StopWatchController get to => Get.find();

  late SharedPreferences prefs;

  // 计时控制器
  late StopWatchTimer stopWatchTimer;

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

  /// 预置初始时间
  var lapPresetTime = 0.obs;

  /// 插入lapTime时更新List
  var lapListglobalKey = GlobalKey<AnimatedListState>().obs;

  /// lapList滚动控制器
  var lapListScrollController = ScrollController().obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    initLapTimeList();

    /// 节流 防止millsecond刷新过快
    interval(
      timerMillSecond,
      (callback) => update(['stop_watch_ms']),
      time: const Duration(milliseconds: 50),
    );
  }

  /// 初始化时间
  void initLapTimeList() {
    lapTimeList.value = prefs.getStringList('lapTimeList') ?? [];
    lapIntervalList.value = prefs.getStringList('lapIntervalList') ?? [];
    lapPresetTime.value = prefs.getInt('lapPresetTime') ?? 0;
    timerMinute.value =
        int.parse(formatTime(lapPresetTime.value).substring(0, 2));
    timerSecond.value =
        int.parse(formatTime(lapPresetTime.value).substring(3, 5));
    timerMillSecond.value =
        int.parse(formatTime(lapPresetTime.value).substring(6, 8));
  }

  /// 开始计时
  void startTimer() {
    late int _timerSecond;
    late int _timerMinute;
    isTiming.value = true;
    // 创建计时器控制器
    stopWatchTimer = StopWatchTimer(
      isLapHours: false,
      onChange: (v) async {
        timerMillSecond.value =
            int.parse(StopWatchTimer.getDisplayTimeMillisecond(v));
        _timerSecond = int.parse(StopWatchTimer.getDisplayTimeSecond(v));
        _timerMinute = int.parse(StopWatchTimer.getDisplayTimeMinute(v));
        lapPresetTime.value = StopWatchTimer.getRawSecond(v) * 1000;

        await prefs.setInt('lapPresetTime', lapPresetTime.value);
      },
      onChangeRawSecond: (v) => timerSecond.value = _timerSecond,
      onChangeRawMinute: (v) => timerMinute.value = _timerMinute,
    );
    stopWatchTimer.setPresetTime(mSec: lapPresetTime.value);
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

    lapTimeList.clear();
    lapIntervalList.clear();
    lapPresetTime.value = 0;

    stopWatchTimer.clearPresetTime();
    stopWatchTimer.dispose();

    await prefs.setInt('lapPresetTime', lapPresetTime.value);
    await prefs.setStringList('lapTimeList', lapTimeList);
    await prefs.setStringList('lapIntervalList', lapIntervalList);
  }

  /// 记录单圈时间
  void recordLapTime() async {
    stopWatchTimer.onExecute.add(StopWatchExecute.lap);
    String lapTime =
        '${timerMinute.toString().padLeft(2, '0')}:${timerSecond.toString().padLeft(2, '0')}.${timerMillSecond.toString().padLeft(2, '0')}';

    // 插入数据并通知组件更新
    lapTimeList.insert(0, lapTime);
    lapListglobalKey.value.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 200),
    );
    countLapInterval();

    // 滚动列表到最顶部
    lapListScrollController.value.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutExpo,
    );

    await prefs.setStringList('lapTimeList', lapTimeList);
    await prefs.setStringList('lapIntervalList', lapIntervalList);
  }

  /// 记录单圈时间间隔
  void countLapInterval() {
    if (lapIntervalList.isEmpty) {
      lapIntervalList.add('00:00.00');
    } else {
      int lastLapTime = int.parse(lapTimeList[1].substring(0, 2)) * 60 * 1000 +
          int.parse(lapTimeList[1].substring(3, 5)) * 1000 +
          int.parse(lapTimeList[1].split('.')[1]) * 10;

      int nowLapTime = int.parse(lapTimeList[0].substring(0, 2)) * 60 * 1000 +
          int.parse(lapTimeList[0].substring(3, 5)) * 1000 +
          int.parse(lapTimeList[0].split('.')[1]) * 10;

      int _lapInterval = nowLapTime - lastLapTime;

      // 在列表首位插入
      lapIntervalList.insert(0, formatTime(_lapInterval));
    }
  }

  /// 将毫秒转化为 分/秒/毫秒
  String formatTime(int ms) {
    var millisecond = (ms % 1000).truncate();
    var second = 0;
    var totalMinute = 0;
    var minute = 0;
    var result = "";
    var totalSecond = (ms / 1000).truncate(); // 3671
    if (totalSecond > 59) {
      // 总秒数大于59 需要计算总分钟 数
      second = (totalSecond % 60).truncate(); // 11
      totalMinute = (totalSecond / 60).truncate(); // 61
    } else {
      second = totalSecond;
    }
    if (totalMinute > 59) {
      minute = (totalMinute % 60).truncate(); // 1
    } else {
      minute = totalMinute;
    }

    result += minute.toString().padLeft(2, '0');
    result += ':' + second.toString().padLeft(2, '0');
    result += "." + millisecond.toString().padLeft(3, '0').substring(0, 2);

    return result;
  }

  @override
  void onClose() async {
    super.onClose();
    stopWatchTimer.dispose();
  }
}
