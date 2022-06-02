import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/timer_controller.dart';

/// 自定义Get的通知组件[GetSnackBar()]
class GetNotification {
  /// 显示Toast
  ///
  /// [maxWidth],[minWidth]用于适配中文和英文文字长度
  static SnackbarController showToastSnakbar(
    String message, {
    required double maxWidth,
    required double minWidth,
  }) {
    return Get.showSnackbar(
      GetSnackBar(
        messageText: Center(
          child: Text(
            message.tr,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(Get.context!).primaryColor,
              height: 1.1,
            ),
          ),
        ),
        maxWidth: Get.locale!.languageCode == 'zh' ? minWidth : maxWidth,
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
        backgroundColor: Theme.of(Get.context!).cardColor,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        borderRadius: 15,
        boxShadows: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            offset: const Offset(0, 2),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
    );
  }

  ///  计时结束通知
  static SnackbarController showTimerToast() {
    var controller = Get.put(TimerController());
    var _seconds = 0.obs;
    Timer _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _seconds.value++;
      },
    );
    return Get.showSnackbar(
      GetSnackBar(
        titleText: Obx(
          () => Text(
            controller.timerTitle.value + 'has_stopped'.tr,
            style: TextStyle(
              color: Theme.of(Get.context!).primaryColor,
              fontSize: 18,
              height: 1.1,
            ),
          ),
        ),
        messageText: Obx(
          () => Text(
            '${_seconds.value}' + 'second_ago'.tr,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(Get.context!).primaryColor,
              height: 1.1,
            ),
          ),
        ),
        onTap: (snack) => Get.back(),
        maxWidth: Get.width - 45,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
        snackPosition: SnackPosition.TOP,
        isDismissible: true, // 启用手势控制
        dismissDirection: DismissDirection.horizontal, // 允许左右滑动关闭通知
        reverseAnimationCurve: Curves.fastOutSlowIn,
        backgroundColor: Theme.of(Get.context!).cardColor,
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
          onPressed: () => Get.back(),
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
                // 如果开启手势控制, 须在此时调用关闭通知铃声
                FlutterRingtonePlayer.stop();
                _timer.cancel();

                break;
              }
            case SnackbarStatus.CLOSING:
              {
                // FlutterRingtonePlayer.stop();
                // _timer.cancel();
                break;
              }
            default:
              break;
          }
        },
      ),
    );
  }
}
