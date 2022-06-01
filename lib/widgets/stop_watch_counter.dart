import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/controller/stop_watch_controller.dart';

class StopWatchCounter extends GetView<StopWatchController> {
  const StopWatchCounter({
    Key? key,
    this.size = 50,
  }) : super(key: key);

  final double size;

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
                    ? Colors.grey.withOpacity(.3)
                    : Theme.of(context).primaryColor,
                fontSize: size,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              ':',
              style: TextStyle(
                fontSize: size,
                color: controller.timerMinute.value == 0
                    ? Colors.grey.withOpacity(.3)
                    : Theme.of(context).primaryColor,
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
                    ? Colors.grey.withOpacity(.3)
                    : Theme.of(context).primaryColor,
                fontSize: size,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '.',
              style: TextStyle(
                fontSize: size,
                color: Theme.of(context).toggleableActiveColor,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ).marginOnly(left: 5, right: 5),

            // millsecond
            GetBuilder(
              id: 'stop_watch_ms',
              init: StopWatchController(),
              builder: (_) => Text(
                controller.timerMillSecond.value.toString().padLeft(2, '0'),
                style: TextStyle(
                  color: (controller.timerMillSecond.value == 0 &&
                              !controller.isTiming.value) ||
                          controller.isPauseTiming.value
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(.5),
                  fontSize: size,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
