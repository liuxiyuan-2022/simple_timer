import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/controller/settings_controller.dart';
import 'package:simple_timer/widgets/main_page.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SettingsController(),
      builder: (_) {
        return MainPage(
          appBarTitle: '| 设置',
          child: Center(
            child: Text('Setting Page'),
          ),
        );
      },
    );
  }
}
