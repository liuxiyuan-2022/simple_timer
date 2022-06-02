import 'dart:async';
import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/common/get_notification.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static TimerController get to => Get.find();

  /// 持久化
  late SharedPreferences prefs;

  /// 倒计时控制器
  var stopWatchTimer = StopWatchTimer();

  /// 计时刻度圆环动画控制器
  late Animation animation;
  late AnimationController animationController;

  /// 是否正在计时
  var isTiming = false.obs;

  /// 是否暂停计时
  var isPauseTiming = false.obs;

  /// 当前计时器标题
  var timerTitle = '计时器'.obs;

  /// 计时器 - 秒
  var timerSecond = 0.obs;

  /// 计时器 - 分
  var timerMinute = 0.obs;

  /// 计时器 - 小时
  var timerHour = 0.obs;

  /// 计时器总时长 /秒
  var totalTime = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    // 初始化本地持久化
    prefs = await SharedPreferences.getInstance();

    // 初始化tiemrScaleRing动画控制器
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = Tween(begin: 0.0, end: pi * 2 / 24)
        .chain(CurveTween(curve: Curves.elasticOut))
        .animate(animationController)
      ..addListener(() => update());

    // 初始化计时时间
    initTimer();
  }

  /// 开始计时
  void startTimer() {
    late int _timerSecond;
    late int _timerMinute;
    late int _timerHour;
    isTiming.value = true;

    if (Get.isSnackbarOpen) {
      Get.back();
    }

    // 保存计时时间
    saveTimer();

    // 将单位转化为秒
    totalTime.value = timerToSecond(
      timerHour.value,
      timerMinute.value,
      timerSecond.value,
    );

    // 创建计时器控制器
    stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown, // 模式: 倒计时
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(totalTime.value),
      onChange: (v) {
        _timerHour = int.parse(StopWatchTimer.getDisplayTimeHours(v));
        _timerSecond = int.parse(StopWatchTimer.getDisplayTimeSecond(v));

        // 防止出现当 hour > 0 时 minute = hour + minute 的bug
        if (_timerHour != 0) {
          _timerMinute = int.parse(StopWatchTimer.getDisplayTimeMinute(v)) -
              _timerHour * 60;
        } else {
          _timerMinute = int.parse(StopWatchTimer.getDisplayTimeMinute(v));
        }
      },
      onChangeRawSecond: (v) {
        timerSecond.value = _timerSecond;
        timerMinute.value = _timerMinute;
        timerHour.value = _timerHour;
      },

      // 计时停止时调用:
      onEnded: () {
        stopTimer();
        GetNotification.showTimerToast();
        initTimer();
      },
    );

    stopWatchTimer.onExecute.add(StopWatchExecute.start); // 启动计时器
    animationController.repeat(); // 播放时刻环动画
  }

  /// 暂停计时
  void pauseTimer() {
    isPauseTiming.value = true;
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    animationController.forward();
  }

  /// 恢复计时
  void resumeTimer() {
    isPauseTiming.value = false;
    stopWatchTimer.onExecute.add(StopWatchExecute.start);
    animationController.repeat();
  }

  /// 停止计时
  void stopTimer() {
    isTiming.value = false;
    isPauseTiming.value = false;
    stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    animationController.forward();
    initTimer();
  }

  /// 保存计时时间
  void saveTimer() async {
    String _h = timerHour.value.toString();
    String _m = timerMinute.value.toString();
    String _s = timerSecond.value.toString();
    await prefs.setStringList('lastTimer', <String>[_h, _m, _s]);
  }

  /// 初始化计时时间
  void initTimer() async {
    List<String> timeItems =
        prefs.getStringList('lastTimer') ?? ['0', '5', '0'];
    timerHour.value = int.parse(timeItems[0]);
    timerMinute.value = int.parse(timeItems[1]);
    timerSecond.value = int.parse(timeItems[2]);
  }

  /// 将小时 + 分 + 秒 转化单位为 秒
  int timerToSecond(int h, int m, int s) {
    return h * 60 * 60 + m * 60 + s;
  }

  @override
  void onClose() async {
    super.onClose();
    animationController.dispose();
    await stopWatchTimer.dispose();
  }
}
