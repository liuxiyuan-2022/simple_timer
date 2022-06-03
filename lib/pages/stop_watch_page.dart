import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/controller/stop_watch_controller.dart';
import 'package:simple_timer/widgets/main_page_template.dart';
import 'package:simple_timer/widgets/stop_watch_counter.dart';
import 'package:simple_timer/widgets/stop_watch_lap_list.dart';
import 'package:simple_timer/widgets/stop_watch_status_button.dart';

class StopWatchPage extends GetView<StopWatchController> {
  const StopWatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(StopWatchController(), permanent: true); // 不消毁此控制器

    return MainPageTemplate(
      appBarTitle: 'stop_watch_page'.tr,
      child: Stack(
        children: [
          Positioned(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => AnimatedSlide(
                      offset:
                          Offset(0, controller.lapTimeList.isEmpty ? 0 : -0.7),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      child: const StopWatchCounter(size: 60)),
                ),
                const StopWatchLapList(),
              ],
            ),
            top: 125,
          ),
          const Positioned(
            child: StopWatchStatusButton(size: 70),
            bottom: 30,
          ),
        ],
      ),
    );
  }
}
