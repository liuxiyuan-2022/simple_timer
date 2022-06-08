import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_timer/common/data_util.dart';
import 'package:simple_timer/common/get_notification.dart';
import 'package:simple_timer/controller/timer_controller.dart';

/// 计时器预设列表控制器
class TimerListController extends GetxController {
  static TimerListController get to => Get.find();

  /// 持久化
  late SharedPreferences prefs;

  /// 输入框控制器
  TextEditingController editController = TextEditingController();

  /// 计时器列表
  /// 如: [ ['00:15:00', '洗衣服'],['add] ]
  List<List<String>> timerList = [];

  /// 计时器列表Page页数
  var pageCount = 1.obs;

  /// 计时器时间列表的时间预设值
  var timerListHour = 0.obs;
  var timerListMinute = 0.obs;
  var timerListSecond = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    // 初始化本地持久化
    prefs = await SharedPreferences.getInstance();
    // 初始化计时器列表
    initTimerList();
  }

  /// 初始化timerPicker的时间
  void initTimerPicker(int index) {
    timerListHour.value = int.parse(timerList[index][0].split(':')[0]);
    timerListMinute.value = int.parse(timerList[index][0].split(':')[1]);
    timerListSecond.value = int.parse(timerList[index][0].split(':')[2]);
  }

  /// 初始化计时器预设列表
  void initTimerList() {
    int length = prefs.getInt('timerListLength') ?? 0;
    if (length == 0) {
      timerList = [
        ['add']
      ];
    } else {
      for (var i = 0; i < length; i++) {
        List<String> value = prefs.getStringList('timerList_$i')!;
        timerList.add(value);
      }
    }
    pageCount.value = (timerList.length / 6).ceil(); // 向上取整
    update(['timerList']);
  }

  /// 添加计时器预设
  void addTimer() {
    String timeStr = DataUtil.timeToString(
      timerListHour.value,
      timerListMinute.value,
      timerListSecond.value,
    );
    String timerTag =
        editController.text == '' ? 'timer'.tr : editController.text;
    timerList.insert(timerList.length - 1, [timeStr, timerTag]);
    saveTimerList();
  }

  /// 更改计时器预设时间
  void changeTimerListTime(int index) {
    String result = DataUtil.timeToString(
      timerListHour.value,
      timerListMinute.value,
      timerListSecond.value,
    );
    timerList[index][0] = result;
    saveTimerList();
  }

  /// 重命名计时器预设标签
  void renameTimerTag(int index) {
    timerList[index][1] = editController.text;
    saveTimerList();
  }

  /// 删除计时器预设
  void removeTimer(int index) {
    GetNotification.showCustomBottomSheet(
      title: 'remove_timer'.tr,
      confirmTitle: 'remove'.tr,
      confirmOnTap: () {
        timerList.removeAt(index);
        saveTimerList();
        while (Get.isBottomSheetOpen!) {
          Get.back();
        }
      },
    );
  }

  /// 保存计时器预设列表
  void saveTimerList() async {
    int index = 0;
    for (var item in timerList) {
      await prefs.setStringList('timerList_$index', item);
      await prefs.setInt('timerListLength', timerList.length);
      index++;
    }
    pageCount.value = (timerList.length / 6).ceil(); // 向上取整
    // 更新列表
    update(['timerList']);
  }

  /// 使用计时器预设
  void applyTimerListInfo(int index) {
    TimerController.to.timerHour.value =
        int.parse(timerList[index][0].split(":")[0]);
    TimerController.to.timerMinute.value =
        int.parse(timerList[index][0].split(':')[1]);
    TimerController.to.timerSecond.value =
        int.parse(timerList[index][0].split(':')[2]);
    TimerController.to.timerTag.value = timerList[index][1];
  }

  @override
  void dispose() {
    super.dispose();
    saveTimerList();
  }
}
