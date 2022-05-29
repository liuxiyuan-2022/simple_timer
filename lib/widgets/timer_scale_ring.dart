import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/timer_controller.dart';

class TimerScaleRing extends GetView<TimerController> {
  const TimerScaleRing({Key? key, required this.scale}) : super(key: key);

  final double scale;

  @override
  Widget build(BuildContext context) {
    List<Widget> scaleRing() {
      List<Widget> widgetList = [];

      for (var item = 0; item < 24; item++) {
        widgetList.add(
          Transform.rotate(
            angle: pi * 2 / 24 * item,
            child: SizedBox(
              height: scale,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 5,
                    height: 15,
                    decoration: BoxDecoration(
                      color: ColorUtil.hex("#939ba3"),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return widgetList;
    }

    return GetBuilder(
      init: TimerController(),
      builder: (_) {
        return Transform.translate(
          offset: const Offset(-2.5, 0),
          child: Transform.rotate(
            angle: controller.animation.value,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: scaleRing(),
            ),
          ),
        );
      },
    );
  }
}
