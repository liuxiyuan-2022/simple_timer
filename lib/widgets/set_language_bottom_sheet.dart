import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_timer/controller/settings_controller.dart';

class SetLanguageBottomSheet extends GetView<SettingsController> {
  const SetLanguageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());

    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: Column(
        children: [
          Text(
            'set_Language'.tr,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ).marginOnly(bottom: 25),
          // 可选语言列表
          ListView.builder(
            shrinkWrap: true,
            itemCount: AppLanguage.values.length,
            itemExtent: 50,
            padding: const EdgeInsets.only(left: 5, right: 5),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      controller.changeLanguage(AppLanguage.values[index]);
                      Get.back();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.languageTitleList[index],
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            // fontWeight: FontWeight.w700,
                          ),
                        ),
                        Opacity(
                          opacity: controller.language.value ==
                                  AppLanguage.values[index]
                              ? 1
                              : 0,
                          child: FaIcon(
                            FontAwesomeIcons.check,
                            color: Theme.of(context).toggleableActiveColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey[400]),
                ],
              );
            },
          ),
        ],
      ),
    ).marginOnly(left: 30, right: 30, bottom: 25);
  }
}
