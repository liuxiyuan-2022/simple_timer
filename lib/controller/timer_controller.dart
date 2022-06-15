import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/common/data_util.dart';
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
  var timerTag = 'timer'.obs;

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

    initTimer();
    initAnimationController();
    initNotification();
  }

  /// 初始化通知
  void initNotification() {
    // 为 actionButtons 创建监听事件
    AwesomeNotifications().actionStream.listen((event) {
      // 监测按钮的Key值
      switch (event.buttonKeyPressed) {
        case 'timer_confirm':
          Get.closeAllSnackbars();
          break;
        default:
      }
    });

    AwesomeNotifications().initialize(
      'resource://drawable/launcher_icon', // 自定义通知图标
      [
        NotificationChannel(
          channelKey: 'timer_channel', // 通知频道Key
          channelGroupKey: 'timer_channel_group', // 通知频道组Key
          channelName: '计时器通知', // 通知频道名称
          channelDescription: 'Notification channel for basic tests',
          enableVibration: false, // 是否启用震动
          playSound: false, // 是否播放声音
          locked: false, // 不允许手动关闭通知
          importance: NotificationImportance.Max,
          channelShowBadge: true,
        )
      ],
      debug: true,
    );
  }

  /// 初始化计时时间
  void initTimer() async {
    List<String> timeItems =
        prefs.getStringList('lastTimer') ?? ['0', '5', '0'];
    timerHour.value = int.parse(timeItems[0]);
    timerMinute.value = int.parse(timeItems[1]);
    timerSecond.value = int.parse(timeItems[2]);
  }

  /// 初始化tiemrScaleRing动画控制器
  void initAnimationController() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = Tween(begin: 0.0, end: pi * 2 / 24)
        .chain(CurveTween(curve: Curves.elasticOut))
        .animate(animationController)
      ..addListener(() => update());
  }

  /// 创建计时器后台通知
  ///
  /// id: 1
  Future<void> createTimerNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'timer_channel',
        title: timerTag.value + '已到时',
        notificationLayout: NotificationLayout.BigText,
        displayOnForeground: false,
        displayOnBackground: true,
        wakeUpScreen: true,
        fullScreenIntent: true,
        category: NotificationCategory.Message,
        locked: true,
        color: ColorUtil.hex('#bab9ba'),
      ),
      actionButtons: <NotificationActionButton>[
        NotificationActionButton(
          key: 'timer_confirm',
          label: '确定',
        ),
      ],
    );
  }

  /// 开始计时
  void startTimer() {
    late int _timerSecond;
    late int _timerMinute;
    late int _timerHour;

    /// 检查通知权限是否开启
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // 询问是否开启权限
        GetNotification.showCustomBottomSheet(
          title: 'open_notification_permissions'.tr,
          message: '计时器到时提醒需要通知权限, 请确保开启此权限',
          confirmTitle: 'open'.tr,
          confirmOnTap: () =>
              AwesomeNotifications().requestPermissionToSendNotifications(
            permissions: [
              NotificationPermission.Alert,
              NotificationPermission.Badge,
              NotificationPermission.Light,
              NotificationPermission.FullScreenIntent,
            ],
          ).then((_) => Get.back()),
        );
      } else {
        isTiming.value = true;
        Get.closeAllSnackbars();

        // 保存下次计时默认时间
        saveTimer();

        // 将单位转化为秒
        totalTime.value = DataUtil.timeToSecond(
          timerHour.value,
          timerMinute.value,
          timerSecond.value,
        );

        // 创建计时器控制器
        stopWatchTimer = StopWatchTimer(
          mode: StopWatchMode.countDown, // 模式: 倒计时
          presetMillisecond:
              StopWatchTimer.getMilliSecFromSecond(totalTime.value),
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
    });
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

  /// 保存计时器时间
  void saveTimer() async {
    String _h = timerHour.value.toString();
    String _m = timerMinute.value.toString();
    String _s = timerSecond.value.toString();
    await prefs.setStringList('lastTimer', <String>[_h, _m, _s]);
  }

  @override
  void onClose() async {
    super.onClose();
    // saveTimerList();
    animationController.dispose();
    await stopWatchTimer.dispose();
  }
}
