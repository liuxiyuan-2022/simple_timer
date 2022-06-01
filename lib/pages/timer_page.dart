import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/timer_controller.dart';
import 'package:simple_timer/widgets/main_page.dart';
import 'package:simple_timer/widgets/timer_flip_counter.dart';
import 'package:simple_timer/widgets/timer_picker.dart';
import 'package:simple_timer/widgets/timer_scale_ring.dart';
import 'package:simple_timer/widgets/timer_status_button.dart';

class TimerPage extends GetView<TimerController> {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TimerController(), permanent: true); // 不销毁此控制器

    return MainPage(
      appBarTitle: "timer".tr,
      appBarActions: [
        IconButton(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.ellipsis),
        ).marginOnly(right: 10)
      ],
      child: SizedBox(
        width: context.width,
        height: context.height,
        child: Obx(
          () => Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Visibility(
                visible: controller.isTiming.value ? true : false,
                child: Positioned(
                  child: TimerScaleRing(
                    scale: context.width * 1.3,
                  ),
                  top: -context.height / 3.5,
                  left: context.width / 2,
                ),
              ),
              Visibility(
                visible: controller.isTiming.value ? true : false,
                child: TimerFlipCounter(
                  size: 50,
                  timeColor: ColorUtil.hex("#34384a"),
                  titleColor: ColorUtil.hex("#939ba3"),
                ),
              ),
              Visibility(
                visible: controller.isTiming.value ? false : true,
                child: const TimerPicker(),
              ).marginOnly(top: 50),
              const Positioned(
                child: TimerStatusButton(size: 70),
                bottom: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
