import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:simple_timer/controller/settings_controller.dart';
import 'package:simple_timer/pages/about_page.dart';
import 'package:simple_timer/widgets/main_page_template.dart';
import 'package:simple_timer/widgets/set_language_bottom_sheet.dart';
import 'package:simple_timer/widgets/set_option.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());

    return Obx(
      () => MainPageTemplate(
        appBarTitle: 'setting'.tr,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Card_2
            Card(
              shape: Theme.of(context).cardTheme.shape,
              shadowColor: Theme.of(context).cardTheme.shadowColor,
              elevation: Theme.of(context).cardTheme.elevation,
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  /*
                      默认铃声
                    */
                  SetOption(
                    leading: FontAwesomeIcons.solidBell,
                    title: 'ringtone'.tr,
                    onTap: () {},
                  ),
                ],
              ),
            ).marginOnly(bottom: 5),

            /// 设备
            Card(
              shape: Theme.of(context).cardTheme.shape,
              shadowColor: Theme.of(context).cardTheme.shadowColor,
              elevation: Theme.of(context).cardTheme.elevation,
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  /*
                      夜间模式
                    */
                  SetOption(
                    leading: FontAwesomeIcons.cloudMoon,
                    title: "dark_mode".tr,
                    actions: [
                      Switch(
                        inactiveTrackColor: Colors.grey.withOpacity(.4),
                        inactiveThumbColor: Colors.white,
                        value: controller.isDarkMode.value,
                        onChanged: ((value) {
                          controller.changeMode(value);
                        }),
                      ),
                    ],
                    showArrowRight: false,
                  ),
                  SetOption(
                    leading: FontAwesomeIcons.flask,
                    title: 'lab'.tr,
                    onTap: () {},
                  ),

                  /*
                      语言
                    */
                  SetOption(
                    leading: FontAwesomeIcons.language,
                    title: 'language'.tr,
                    onTap: () => Get.bottomSheet(
                      const SetLanguageBottomSheet(),
                    ),
                    iconStyle: SetOptionIconStyle.faIcon,
                    actions: [
                      Text(
                        controller.languageTitleList[AppLanguage.values
                            .indexOf(controller.language.value)],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ).marginOnly(bottom: 5),

            // Card_1
            Card(
              shape: Theme.of(context).cardTheme.shape,
              shadowColor: Theme.of(context).cardTheme.shadowColor,
              elevation: Theme.of(context).cardTheme.elevation,
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  /*
                      检查更新
                    */
                  SetOption(
                    leading: FontAwesomeIcons.earthAsia,
                    title: 'check_updates'.tr,
                    onTap: () => controller.checkVersion(),
                    actions: [
                      Visibility(
                        visible: !controller.isLatestVersion.value,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ).marginOnly(right: 2.5),
                    ],
                  ),

                  /*
                      关于
                    */
                  SetOption(
                    leading: FontAwesomeIcons.circleInfo,
                    title: 'about'.tr,
                    onTap: () => Get.to(
                      const AboutPage(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                    ),
                  ),
                ],
              ),
            ).marginOnly(bottom: 5),
          ],
        ),
      ),
    );
  }
}
