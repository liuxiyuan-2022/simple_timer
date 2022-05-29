import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/stop_watch_controller.dart';

class StopWatchCounter extends GetView<StopWatchController> {
  const StopWatchCounter({
    Key? key,
    this.size = 50,
    this.activityColor = Colors.black,
    this.inactiveColor = Colors.grey,
    this.printColor = Colors.redAccent,
  }) : super(key: key);

  final double size;

  // 数字颜色
  final Color activityColor;

  // 当 秒/分 值为0时数字的颜色
  final Color inactiveColor;

  //
  final Color printColor;

  @override
  Widget build(BuildContext context) {
    Get.put(StopWatchController());

    return Obx(
      () => SizedBox(
        width: context.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 分
            AnimatedFlipCounter(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              value: controller.timerMinute.value,
              wholeDigits: 2,
              textStyle: TextStyle(
                color: controller.timerMinute.value == 0
                    ? inactiveColor
                    : activityColor,
                fontSize: size,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              ':',
              style: TextStyle(
                fontSize: size,
                color: controller.timerMinute.value == 0
                    ? inactiveColor
                    : activityColor,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ).marginOnly(left: 5, right: 5),

            // 秒
            AnimatedFlipCounter(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              value: controller.timerSecond.value,
              wholeDigits: 2,
              textStyle: TextStyle(
                color: controller.timerSecond.value == 0
                    ? inactiveColor
                    : activityColor,
                fontSize: size,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '.',
              style: TextStyle(
                fontSize: size,
                color: printColor,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ).marginOnly(left: 5, right: 5),
            AnimatedFlipCounter(
              duration: const Duration(milliseconds: 1),
              curve: Curves.easeOutBack,
              value: controller.timerMillSecond.value,
              wholeDigits: 2,
              textStyle: TextStyle(
                color: controller.timerMillSecond.value == 0 ||
                        controller.isPauseTiming.value
                    ? activityColor
                    : activityColor.withOpacity(.5),
                fontSize: size,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
