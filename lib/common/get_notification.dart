import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/settings_controller.dart';
import 'package:simple_timer/controller/timer_controller.dart';
import 'package:simple_timer/controller/timer_list_controller.dart';
import 'package:simple_timer/widgets/bottom_sheet_box.dart';
import 'package:simple_timer/widgets/main_text_field.dart';
import 'package:simple_timer/widgets/timer_picker.dart';

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

  /// 显示自定义的GetBottomSheet
  ///
  /// [isfixedButton] 当键盘调出时是否固定<确认>和<取消>按钮 默认false
  static Future<T?> showCustomBottomSheet<T>({
    required String title,
    String? message,
    String? confirmTitle,
    Color? confirmBorderColor,
    Color? confirmTextColor,
    String? cancelTitle,
    Color? cancelTextColor,
    Function()? confirmOnTap,
    Function()? cancelOnTap,
    List<Widget> children = const <Widget>[],
    bool? isfixedButton,
  }) {
    TimerController.to.isShowKeyboard.value = false; // 先初始化值, 避免出现bug
    return Get.bottomSheet(
      Obx(() => BottomSheetBox(
            children: [
              // 标题
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(Get.context!).primaryColor,
                ),
              ).marginOnly(bottom: 15),
              // 内容
              Visibility(
                visible: message == null ? false : true,
                child: Text(
                  message ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              // 组件
              Visibility(
                visible: children.isEmpty ? false : true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                ),
              ),
              // 如果打开键盘就隐藏按钮
              // 确定按钮
              Visibility(
                visible: TimerController.to.isShowKeyboard.value
                    ? (isfixedButton ?? false)
                    : true,
                maintainAnimation: true,
                maintainSize: true,
                maintainState: true,
                child: TextButton(
                  onPressed: confirmOnTap,
                  child: Container(
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: confirmBorderColor ??
                            Theme.of(Get.context!).toggleableActiveColor,
                        width: 3,
                      ),
                    ),
                    child: Text(
                      confirmTitle ?? 'confirm'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: confirmTextColor ??
                            Theme.of(Get.context!).toggleableActiveColor,
                        fontSize: 16,
                        height: 1.1,
                      ),
                    ).marginOnly(top: 12.5, bottom: 12.5),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                ).marginOnly(bottom: 5, top: 20),
              ),
              // 取消按钮
              Visibility(
                visible: TimerController.to.isShowKeyboard.value
                    ? (isfixedButton ?? false)
                    : true,
                maintainAnimation: true,
                maintainSize: true,
                maintainState: true,
                child: TextButton(
                  onPressed: cancelOnTap ??
                      () {
                        // 关闭弹窗
                        while (Get.isBottomSheetOpen!) {
                          Get.back();
                        }
                      },
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      cancelTitle ?? 'cancel'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: cancelTextColor ??
                            Theme.of(Get.context!).primaryColor,
                        fontSize: 16,
                        height: 1.1,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                ),
              ),
            ],
          )),
      barrierColor: Colors.black12,
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
      barrierColor: Colors.black12,
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
      barrierColor: Colors.black12,
    );
  }

  /// 显示计时器预设编辑菜单条
  static Future<T?> showEditBar<T>(int index) {
    return Get.bottomSheet(
      BottomSheetBox(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        children: [
          // 重命名
          InkWell(
            onTap: () => showRenameTagBottomSheet(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.solidPenToSquare,
                  size: 25,
                  color: ColorUtil.hex("#f18435"),
                ),
                Text(
                  'rename'.tr,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ).marginOnly(top: 10),
              ],
            ),
          ),

          // 调整时间
          InkWell(
            onTap: () => showEditTimeBottomSheet(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.solidClock,
                  size: 25,
                  color: ColorUtil.hex("#01cdcc"),
                ),
                Text(
                  'change_time'.tr,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ).marginOnly(top: 10),
              ],
            ),
          ),

          // 删除
          InkWell(
            onTap: () => TimerListController.to.removeTimer(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.solidTrashCan,
                  size: 25,
                  color: ColorUtil.hex("#ec602d"),
                ),
                Text(
                  'remove'.tr,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ).marginOnly(top: 10),
              ],
            ),
          ),
        ],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            offset: const Offset(0, 2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      barrierColor: SettingsController.to.isDarkMode.value
          ? Colors.transparent
          : Colors.black12,
    );
  }

  ///  显时计时器预设时间编辑框 <修改时间>
  static Future<T?> showEditTimeBottomSheet<T>(int index) {
    TimerListController.to.initTimerPicker(index);
    return showCustomBottomSheet(
      title: 'change_time'.tr,
      confirmOnTap: () {
        TimerListController.to.changeTimerListTime(index);
        while (Get.isBottomSheetOpen!) {
          Get.back();
        }
      },
      confirmBorderColor: Theme.of(Get.context!).primaryColor,
      confirmTextColor: Theme.of(Get.context!).primaryColor,
      children: [
        TimerPicker(
          hourValue: TimerListController.to.timerListHour,
          minuteValue: TimerListController.to.timerListMinute,
          secondValue: TimerListController.to.timerListSecond,
          scale: .8,
        ),
      ],
    );
  }

  ///  显时计时器预设标签编辑框 <修改标签>
  static Future<T?> showRenameTagBottomSheet<T>(int index) {
    TimerListController.to.initTimerPicker(index);
    TimerListController.to.editController.text =
        TimerListController.to.timerList[index][1];
    return showCustomBottomSheet(
      title: 'rename'.tr,
      confirmOnTap: () {
        TimerListController.to.renameTimerTag(index);
        while (Get.isBottomSheetOpen!) {
          Get.back();
        }
      },
      confirmBorderColor: Theme.of(Get.context!).primaryColor,
      confirmTextColor: Theme.of(Get.context!).primaryColor,
      isfixedButton: true,
      children: [
        const MainTextField().marginOnly(top: 10),
      ],
    );
  }

  /// 显示添加计时器编辑框  <添加预设>
  static Future<T?> showAddTimerBottomSheet<T>() {
    return showCustomBottomSheet(
      title: 'add_timer'.tr,
      confirmTitle: 'add'.tr,
      confirmOnTap: () {
        TimerListController.to.addTimer();
        while (Get.isBottomSheetOpen!) {
          Get.back();
        }
      },
      children: [
        TimerPicker(
          hourValue: TimerListController.to.timerListHour,
          minuteValue: TimerListController.to.timerListMinute,
          secondValue: TimerListController.to.timerListSecond,
          scale: .8,
        ),
        const MainTextField().marginOnly(top: 10),
      ],
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
            TimerController.to.timerTag.value.tr + 'has_stopped'.tr,
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
