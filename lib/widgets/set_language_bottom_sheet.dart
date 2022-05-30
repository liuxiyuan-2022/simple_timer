import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/controller/settings_controller.dart';

class SetLanguageBottomSheet extends GetView<SettingsController> {
  const SetLanguageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());

    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          InkWell(
            onTap: () {
              controller.changeLanguage(AppLanguage.zh_CN);
              Get.back();
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  Text(
                    "简体中文",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              controller.changeLanguage(AppLanguage.en_US);
              Get.back();
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  Text(
                    "English",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
