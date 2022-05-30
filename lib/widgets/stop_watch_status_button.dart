import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/stop_watch_controller.dart';
import 'package:simple_timer/controller/stop_watch_status_button_controller.dart';

class StopWatchStatusButton extends GetView<StopWatchStatusButtonController> {
  const StopWatchStatusButton({
    Key? key,
    this.size = 50,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    Get.put(StopWatchStatusButtonController());

    return Obx(
      () => SizedBox(
        width: context.width, // 防止子组件位移超出父组件后点击事件失效
        child: Stack(
          alignment: Alignment.center,
          children: [
            // StopTiming Button
            AnimatedSlide(
              offset:
                  Offset(StopWatchController.to.isTiming.value ? -1.5 : 0, 0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: AnimatedScale(
                scale: controller.flagBtnScale.value,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: AnimatedOpacity(
                  opacity: StopWatchController.to.isTiming.value ? 1 : 0,
                  duration: const Duration(milliseconds: 400),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapDown: (details) => controller.flagBtnOnTapDown(),
                    onTapUp: (details) => controller.flagBtnOnTapUp(),
                    onTapCancel: () => controller.flagBtnOnTapCancel(),
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
                      child: Center(
                        child: FaIcon(
                          StopWatchController.to.isPauseTiming.value
                              ? FontAwesomeIcons.arrowRotateRight
                              : FontAwesomeIcons.solidFlag,
                          size: size * .3,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // PlayTiming Button
            AnimatedSlide(
              offset:
                  Offset(StopWatchController.to.isTiming.value ? 1.5 : 0, 0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: AnimatedScale(
                scale: controller.startBtnScale.value,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: GestureDetector(
                  onTapDown: (details) => controller.startBtnOnTapDown(),
                  onTapUp: (details) => controller.startBtnOnTapUp(),
                  onTapCancel: () => controller.startBtnOnTapCancel(),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: Theme.of(context).toggleableActiveColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      StopWatchController.to.isPauseTiming.value ||
                              !StopWatchController.to.isTiming.value
                          ? Icons.play_arrow_rounded
                          : Icons.pause_rounded,
                      size: size * .5,
                      color: Theme.of(context).scaffoldBackgroundColor,
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
