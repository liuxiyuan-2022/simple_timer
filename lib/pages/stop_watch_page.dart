import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/controller/stop_watch_controller.dart';
import 'package:simple_timer/widgets/main_page.dart';
import 'package:simple_timer/widgets/stop_watch_counter.dart';
import 'package:simple_timer/widgets/stop_watch_status_button.dart';

class StopWatchPage extends GetView<StopWatchController> {
  const StopWatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(StopWatchController(), permanent: true); // 不消毁此控制器
    return MainPage(
      appBarTitle: 'stop_watch'.tr,
      child: Stack(
        children: const [
          Positioned(
            child: StopWatchCounter(size: 60),
            top: 100,
          ),
          Positioned(
            child: StopWatchStatusButton(size: 60),
            bottom: 20,
          ),
        ],
      ),
    );
  }
}
