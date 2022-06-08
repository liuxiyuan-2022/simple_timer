import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/controller/about_controller.dart';
import 'package:simple_timer/widgets/other_page_template.dart';

class AboutPage extends GetView<AboutController> {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AboutController());
    return OtherPageTemplate(
      appTitle: 'about'.tr,
      body: Container(),
    );
  }
}
