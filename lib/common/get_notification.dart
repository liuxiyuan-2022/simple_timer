import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/settings_controller.dart';
import 'package:simple_timer/controller/timer_controller.dart';
import 'package:simple_timer/widgets/bottom_sheet_box.dart';

/// 自定义Get的通知组件
class GetNotification {
  /// 显示Toast
  ///
  /// [maxWidth],[minWidth]用于适配中文和英文文字长度
  static SnackbarController showToastSnakbar(
    String message, {
    required double maxWidth,
    required double minWidth,
  }) {
    Get.closeAllSnackbars();
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

  /// 显示GetbottomSheet
  static Future<T?> showBottomSheet<T>({
    required String title,
    String? message,
    String? confirmTitle,
    String? cancelTitle,
    Function()? confirmOnTap,
    Function()? cancelOnTap,
  }) {
    return Get.bottomSheet(
      BottomSheetBox(
        children: [
          // 标题
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(Get.context!).primaryColor,
            ),
          ).marginOnly(bottom: 20),
          Text(
            message ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ).marginOnly(bottom: 25),

          TextButton(
            onPressed: confirmOnTap,
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Theme.of(Get.context!).toggleableActiveColor,
                  width: 3,
                ),
              ),
              child: Text(
                confirmTitle ?? 'confirm'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(Get.context!).toggleableActiveColor,
                  fontSize: 16,
                  height: 1.1,
                ),
              ).marginOnly(top: 15, bottom: 15),
            ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
          ).marginOnly(bottom: 5),
          TextButton(
            onPressed: cancelOnTap ?? () => Get.back(),
            child: SizedBox(
              width: 200,
              child: Text(
                cancelTitle ?? 'cancel'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(Get.context!).primaryColor,
                  fontSize: 16,
                  height: 1.1,
                ),
              ),
            ).paddingOnly(top: 15),
          ),
        ],
      ),
    );
  }

  ///  显示语言列表选择框
  static Future<T?> showLanguageBottomSheet<T>() {
    var controller = Get.put(SettingsController());
    return Get.bottomSheet(
      BottomSheetBox(
        children: [
          Text(
            'set_Language'.tr,
            style: TextStyle(
              color: Theme.of(Get.context!).primaryColor,
              fontSize: 16,
            ),
          ).marginOnly(bottom: 20),
          // 可选语言列表
          SizedBox(
            height: 125,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: AppLanguage.values.length,
              itemExtent: 50,
              padding: const EdgeInsets.only(left: 5, right: 5),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    controller.changeLanguage(AppLanguage.values[index]);
                    Get.back();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.languageTitleList[index],
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          Opacity(
                            opacity: controller.language.value ==
                                    AppLanguage.values[index]
                                ? 1
                                : 0,
                            child: FaIcon(
                              FontAwesomeIcons.check,
                              color: Theme.of(context).toggleableActiveColor,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ///  显示铃声列表选择框
  static Future<T?> showRingtonesBottomSheet<T>() {
    // var controller = Get.put(SettingsController());
    return Get.bottomSheet(
      BottomSheetBox(
        children: [
          // 标题
          Text(
            'ringtone'.tr,
            style: TextStyle(
              color: Theme.of(Get.context!).primaryColor,
              fontSize: 16,
            ),
          ).marginOnly(bottom: 20),

          // 选择列表
          SizedBox(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: DefaultRingtones.values.length,
              itemExtent: 50,
              padding: const EdgeInsets.only(left: 5, right: 5),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    FlutterRingtonePlayer.stop();
                    SettingsController.to
                        .changeRingtone(DefaultRingtones.values[index]);
                    // 预览铃声
                    FlutterRingtonePlayer.play(
                      fromAsset: SettingsController.to.defaultRingAsset.value,
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // SettingsController.to.languageTitleList[index],
                            SettingsController.to.ringFromAssetList[index]
                                .split('_')[1]
                                .split('.')[0]
                                .tr,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          Obx(
                            () => FaIcon(
                              SettingsController.to.defaultRing.value ==
                                      DefaultRingtones.values[index]
                                  ? FontAwesomeIcons.solidCircle
                                  : FontAwesomeIcons.circle,
                              color: SettingsController.to.defaultRing.value ==
                                      DefaultRingtones.values[index]
                                  ? Theme.of(context).toggleableActiveColor
                                  : Colors.grey[400],
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ///  显示计时结束通知条
  static SnackbarController showTimerToast() {
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
            TimerController.to.timerTitle.value + 'has_stopped'.tr,
            style: TextStyle(
              color: Theme.of(Get.context!).primaryColor,
              fontSize: 16,
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
                  fromAsset: SettingsController.to.defaultRingAsset.value,
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
}
