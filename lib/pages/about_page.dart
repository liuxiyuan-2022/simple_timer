import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/about_controller.dart';
import 'package:simple_timer/controller/settings_controller.dart';
import 'package:simple_timer/widgets/other_page_template.dart';

class AboutPage extends GetView<AboutController> {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AboutController());

    Widget inkBar({
      required Function() onTop,
      required IconData icon,
      required String title,
    }) {
      return InkWell(
        onTap: onTop,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              child: FaIcon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ).marginOnly(right: 10),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ).marginOnly(top: 10, bottom: 10);
    }

    return Obx(() => OtherPageTemplate(
          appTitle: ''.tr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Text(
                        'Simple',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ).marginOnly(bottom: 5),

                  // 版本信息
                  Text(
                    controller.version.value,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ).marginOnly(bottom: 5),
                  // 介绍
                  Text(
                    controller.message.value,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // 链接
                  inkBar(
                      onTop: () => {},
                      icon: FontAwesomeIcons.squarePollHorizontal,
                      title: 'update_logs'.tr),
                  inkBar(
                    onTop: () => controller.openGitHub(),
                    icon: FontAwesomeIcons.github,
                    title: 'GitHub',
                  ),
                  inkBar(
                    onTop: () {},
                    icon: FontAwesomeIcons.arrowUpRightFromSquare,
                    title: 'share_to_friends'.tr,
                  ),
                ],
              ).marginOnly(left: 45, right: 45),

              // 圆圈装饰
              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Positioned(
                      child: ClipOval(
                        child: Container(
                          width: 450,
                          height: 450,
                          color: ColorUtil.hex("#141414"),
                        ),
                      ),
                      right: -150,
                      bottom: -150,
                    ),
                    //
                    Positioned(
                      child: InkWell(
                        onTap: () => controller.openGitHubHome(),
                        child: const Text(
                          '@ Liuxiyuan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ).paddingAll(10),
                      ),
                      right: 5,
                      bottom: 10,
                    ),
                    //
                    Positioned(
                      child: ClipOval(
                        child: GlassContainer(
                          height: 350,
                          width: 350,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context)
                                  .toggleableActiveColor
                                  .withOpacity(1),
                              Theme.of(context)
                                  .toggleableActiveColor
                                  .withOpacity(0.70),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderGradient: LinearGradient(
                            colors: [
                              Theme.of(context)
                                  .toggleableActiveColor
                                  .withOpacity(0.60),
                              Theme.of(context)
                                  .toggleableActiveColor
                                  .withOpacity(0.10),
                              Colors.lightBlueAccent.withOpacity(0.05),
                              Colors.lightBlueAccent.withOpacity(0.6)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: const [0.0, 0.39, 0.40, 1.0],
                          ),
                          blur: 15.0,
                          borderWidth: 1.5,
                          elevation: 3.0,
                          isFrostedGlass: true,
                          shadowColor: Colors.black.withOpacity(0.20),
                          alignment: Alignment.center,
                          frostedOpacity: 0.12,
                        ),
                      ),
                      left: -120,
                      bottom: -150,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
