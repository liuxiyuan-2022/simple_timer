import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedTab = SelectedTab.home;
  var pageController = PageController();

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
