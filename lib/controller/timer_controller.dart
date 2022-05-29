import 'dart:async';
import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static TimerController get to => Get.find();

  // 持久化
  late SharedPreferences prefs;

  // 倒计时控制器
  var stopWatchTimer = StopWatchTimer();

  // 计时刻度圆环动画控制器
  late Animation animation;
  late AnimationController animationController;

  // 是否正在计时
  var isTiming = false.obs;

  // 是否暂停计时
  var isPauseTiming = false.obs;

  // 当前计时器标题
  var timerTitle = '洗衣服'.obs;

  // 计时器 - 秒
  var timerSecond = 0.obs;

  // 计时器 - 分
  var timerMinute = 0.obs;

  // 计时器 - 小时
  var timerHour = 0.obs;

  // 计时器总时长 /秒
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

  // 开始计时
  void startTimer() {
    late int _timerSecond;
    late int _timerMinute;
    late int _timerHour;
    isTiming.value = true;

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
        timerNotification();
        initTimer();
        printInfo(info: '计时停止');
      },
    );

    stopWatchTimer.onExecute.add(StopWatchExecute.start); // 启动计时器
    animationController.repeat(); // 播放时刻环动画
  }

  // 暂停计时
  void pauseTimer() {
    isPauseTiming.value = true;
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    animationController.forward();
  }

  // 恢复计时
  void resumeTimer() {
    isPauseTiming.value = false;
    stopWatchTimer.onExecute.add(StopWatchExecute.start);
    animationController.repeat();
  }

  // 停止计时
  void stopTimer() {
    isTiming.value = false;
    isPauseTiming.value = false;
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    animationController.forward();
    initTimer();
  }

  // 保存计时时间
  void saveTimer() async {
    String _h = timerHour.value.toString();
    String _m = timerMinute.value.toString();
    String _s = timerSecond.value.toString();
    await prefs.setStringList('lastTimer', <String>[_h, _m, _s]);
  }

  // 初始化计时时间
  void initTimer() async {
    List<String> timeItems =
        prefs.getStringList('lastTimer') ?? ['0', '5', '0'];
    timerHour.value = int.parse(timeItems[0]);
    timerMinute.value = int.parse(timeItems[1]);
    timerSecond.value = int.parse(timeItems[2]);
  }

  // 将小时 + 分 + 秒 转化单位为 秒
  int timerToSecond(int h, int m, int s) {
    return h * 60 * 60 + m * 60 + s;
  }

  // 计时结束通知
  void timerNotification() {
    var _seconds = 0.obs;
    Timer _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _seconds.value++;
      },
    );

    Get.showSnackbar(
      GetSnackBar(
        titleText: Obx(
          () => Text(
            '${timerTitle.value} 已到时',
            style: const TextStyle(fontSize: 18, height: 1.1),
          ),
        ),
        messageText: Obx(
          () => Text(
            '${_seconds.value}秒前',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              height: 1.1,
            ),
          ),
        ),
        maxWidth: Get.width - 45,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.TOP,
        isDismissible: true, // 启用手势控制
        dismissDirection: DismissDirection.horizontal, // 允许左右滑动关闭通知
        onTap: (snack) => Get.back(),
        borderRadius: 15,
        boxShadows: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            offset: const Offset(0, 2),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
        mainButton: TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateProperty.all(Colors.transparent), // 去除点击效果
          ),
          onPressed: () {
            Get.back();
          },
          child: Text(
            '确定',
            style: TextStyle(
              fontSize: 16,
              color: ColorUtil.hex('#ef5562'),
              height: 1.1,
            ),
          ),
        ),
        snackbarStatus: (status) {
          switch (status) {
            case SnackbarStatus.OPENING:
              {
                // 播放提示音
                FlutterRingtonePlayer.play(
                  looping: true,
                  fromAsset: "assets/audio/notification_001.mp3",
                );
                _timer;
                break;
              }
            case SnackbarStatus.OPEN:
              {
                break;
              }
            case SnackbarStatus.CLOSED:
              {
                break;
              }
            case SnackbarStatus.CLOSING:
              {
                FlutterRingtonePlayer.stop();
                _timer.cancel();
                break;
              }
            default:
              break;
          }
        },
      ),
    );
  }

  @override
  void onClose() async {
    super.onClose();
    animationController.dispose();
    await stopWatchTimer.dispose();
  }
}
