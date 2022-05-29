import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/timer_controller.dart';

class TimerFlipCounter extends GetView<TimerController> {
  const TimerFlipCounter({
    Key? key,
    this.size = 40,
    this.timeColor = Colors.black,
    this.titleColor = Colors.black,
  }) : super(key: key);

  final double size;
  final Color timeColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TimerController());

    ThemeData themeData = Theme.of(context).copyWith(
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.w700,
          fontSize: size / 3,
          letterSpacing: 5,
          height: 1.1,
        ),
        headline1: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w700,
          color: timeColor,
        ),
      ),
    );

    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 计时器标题
          Text(
            controller.timerTitle.value,
            style: themeData.textTheme.subtitle1,
          ).marginOnly(bottom: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 小时
              AnimatedFlipCounter(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutBack,
                value: controller.timerHour.value, // pass in a value like 2014
                wholeDigits: 2,
                textStyle: themeData.textTheme.headline1,
              ),
              Text(' : ', style: themeData.textTheme.headline1),
              // 分
              AnimatedFlipCounter(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutBack,
                value:
                    controller.timerMinute.value, // pass in a value like 2014
                wholeDigits: 2,
                textStyle: themeData.textTheme.headline1,
              ),
              Text(' : ', style: themeData.textTheme.headline1),
              // 秒
              AnimatedFlipCounter(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutBack,
                value:
                    controller.timerSecond.value, // pass in a value like 2014
                wholeDigits: 2,
                textStyle: themeData.textTheme.headline1,
              ),
            ],
          ),
          ClipOval(
            child: Container(
              width: 15,
              height: 15,
              color: ColorUtil.hex("#ef5562"),
            ),
          ).marginOnly(top: 50),
        ],
      ),
    );
  }
}
