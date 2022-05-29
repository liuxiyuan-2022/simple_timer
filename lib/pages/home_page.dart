import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/home_controller.dart';
import 'package:simple_timer/pages/stop_watch_page.dart';
import 'package:simple_timer/pages/settings_page.dart';
import 'package:simple_timer/pages/timer_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (_) {
        return Scaffold(
          body: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              TimerPage(),
              StopWatchPage(),
              SettingsPage(),
            ],
          ),
          bottomNavigationBar: DotNavigationBar(
            currentIndex: SelectedTab.values.indexOf(controller.selectedTab),
            onTap: controller.pageViewChanged,
            selectedItemColor: ColorUtil.hex("#ef5562"),
            unselectedItemColor: ColorUtil.hex("#939ba3"),
            itemPadding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ),
            items: [
              DotNavigationBarItem(
                icon: const FaIcon(FontAwesomeIcons.solidHourglass),
              ),
              DotNavigationBarItem(
                icon: const FaIcon(FontAwesomeIcons.stopwatch),
              ),
              DotNavigationBarItem(
                icon: const FaIcon(FontAwesomeIcons.gear),
              ),
            ],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.1),
                offset: const Offset(0, 2),
                spreadRadius: 2,
                blurRadius: 10,
              )
            ],
          ).paddingOnly(bottom: 10),
        );
      },
    );
  }
}
