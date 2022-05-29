import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/controller/stop_watch_controller.dart';
import 'package:simple_timer/widgets/main_page.dart';

class StopWatchPage extends GetView<StopWatchController> {
  const StopWatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StopWatchController(),
      builder: (_) {
        return const MainPage(
          appBarTitle: '| 秒表',
          child: Center(),
        );
      },
    );
  }
}
