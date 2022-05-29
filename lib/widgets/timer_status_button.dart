import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/timer_controller.dart';
import 'package:simple_timer/controller/timer_status_button_controller.dart';

class TimerStatusButton extends GetView<TimerStatusButtonController> {
  const TimerStatusButton({Key? key, this.size = 50}) : super(key: key);

  // 按钮大小
  final double size;

  @override
  Widget build(BuildContext context) {
    Get.put(TimerStatusButtonController());

    return Obx(
      () => SizedBox(
        width: context.width, // 防止子组件位移超出父组件后点击事件失效
        child: Stack(
          alignment: Alignment.center,
          children: [
            // StopTiming Button
            AnimatedSlide(
              offset: Offset(TimerController.to.isTiming.value ? -1.5 : 0, 0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: AnimatedScale(
                scale: controller.stopBtnScale.value,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: AnimatedOpacity(
                  opacity: TimerController.to.isTiming.value ? 1 : 0,
                  duration: const Duration(milliseconds: 400),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapDown: (details) => controller.stopBtnOnTapDown(),
                    onTapUp: (details) => controller.stopBtnOnTapUp(),
                    onTapCancel: () => controller.stopBtnOnTapCancel(),
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: ColorUtil.hex("#9f9f9f"),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: size * .5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // PlayTiming Button
            AnimatedSlide(
              offset: Offset(TimerController.to.isTiming.value ? 1.5 : 0, 0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: AnimatedScale(
                scale: controller.startBtnScale.value,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: AbsorbPointer(
                  absorbing: TimerController.to.timerHour.value == 0 &&
                          TimerController.to.timerMinute.value == 0 &&
                          TimerController.to.timerSecond.value == 0
                      ? true
                      : false, // 当计时器时间为 0s 时禁用点击事件
                  child: GestureDetector(
                    onTapDown: (details) => controller.startBtnOnTapDown(),
                    onTapUp: (details) => controller.startBtnOnTapUp(),
                    onTapCancel: () => controller.startBtnOnTapCancel(),
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: TimerController.to.timerHour.value == 0 &&
                                TimerController.to.timerMinute.value == 0 &&
                                TimerController.to.timerSecond.value == 0
                            ? ColorUtil.hex("#ef5562").withOpacity(.5)
                            : ColorUtil.hex("#ef5562"),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        TimerController.to.isPauseTiming.value ||
                                !TimerController.to.isTiming.value
                            ? Icons.play_arrow_rounded
                            : Icons.pause_rounded,
                        size: size * .5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
