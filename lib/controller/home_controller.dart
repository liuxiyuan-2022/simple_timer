import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simple_timer/controller/settings_controller.dart';

class HomeController extends GetxController {
  SelectedTab selectedTab = SelectedTab.home;
  var pageController = PageController();

  @override
  void onInit() {
    super.onInit();

    // 初始化设置控制器
    Get.put(SettingsController());
  }

  /// 手势滑动切换页面
  void pageViewSlideChanged(double offset) {
    int index = SelectedTab.values.indexOf(selectedTab);
    if (offset > 0) {
      // 右滑
      if (index > 0) {
        pageViewChanged(index - 1);
      }
    } else if (offset < 0) {
      // 左滑
      if (index < SelectedTab.values.length - 1) {
        pageViewChanged(index + 1);
      }
    }
  }

  /// 切换页面
  void pageViewChanged(int i) {
    pageController.animateToPage(
      i,
      duration: const Duration(milliseconds: 3),
      curve: const Threshold(0.1),
    );
    selectedTab = SelectedTab.values[i];
    update();
  }
}

enum SelectedTab { home, stopWatch, settings }
