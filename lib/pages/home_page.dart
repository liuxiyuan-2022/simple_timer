import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/home_controller.dart';
import 'package:simple_timer/controller/timer_controller.dart';
import 'package:simple_timer/pages/stop_watch_page.dart';
import 'package:simple_timer/pages/settings_page.dart';
import 'package:simple_timer/pages/timer_page.dart';
import 'package:simple_timer/widgets/do_navigation_bar.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 滑动手势触点坐标
    double tapDown = 0;
    double tapCancel = 0;

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
          bottomNavigationBar: GestureDetector(
            // 监听导航栏滑动手势
            onHorizontalDragDown: (e) => tapDown = e.localPosition.dx,
            onHorizontalDragUpdate: (e) => tapCancel = e.localPosition.dx,
            onHorizontalDragEnd: (e) {
              double _offset = tapCancel - tapDown;
              controller.pageViewSlideChanged(_offset);
            },
            child: DotNavigationBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              currentIndex: SelectedTab.values.indexOf(controller.selectedTab),
              onTap: controller.pageViewChanged,
              selectedItemColor: ColorUtil.hex("#ef5562"),
              unselectedItemColor: ColorUtil.hex("#939ba3"),
              itemPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 20,
              ),
              dotIndicatorColor: Colors.transparent,
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
            ),
          ).paddingOnly(bottom: 10),
          // floatingActionButton: FloatingActionButton(onPressed: () {
          //   Get.put(TimerController());
          //   TimerController.to.createTimerNotification();
          // }),
        );
      },
    );
  }
}
