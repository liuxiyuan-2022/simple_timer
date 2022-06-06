import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/timer_controller.dart';

class TimerPicker extends GetView<TimerController> {
  const TimerPicker({
    Key? key,
    required this.hourValue,
    required this.minuteValue,
    required this.secondValue,
    this.scale = 1,
  }) : super(key: key);

  // 需要改变的变量 如: [TimerController.to.timerMinute]
  final RxInt hourValue;
  final RxInt minuteValue;
  final RxInt secondValue;

  final double scale;

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context).copyWith(
      textTheme: TextTheme(
        // selectedTextStyle
        headline1: TextStyle(
          fontSize: 40 * scale,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),

        // textStyle
        headline2: TextStyle(
          fontSize: 22 * scale,
          color: ColorUtil.hex('#939ba3').withOpacity(.8),
        ),

        // 时分秒文字
        subtitle1: TextStyle(
          fontSize: 14 * scale,
          fontWeight: FontWeight.w100,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );

    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 小时
              NumberPicker(
                minValue: 0,
                maxValue: 10,
                zeroPad: true,
                itemWidth: 70 * scale,
                itemHeight: 50 * scale,
                // 避免计时时继续刷新此组件
                value: hourValue.value,
                selectedTextStyle: _theme.textTheme.headline1,
                textStyle: _theme.textTheme.headline2,
                infiniteLoop: true,
                onChanged: (value) {
                  hourValue.value = value;
                },
              ),
              Text('timer_hour'.tr, style: _theme.textTheme.subtitle1)
                  .marginOnly(right: 20 * scale),

              // 分钟
              NumberPicker(
                minValue: 0,
                maxValue: 59,
                zeroPad: true,
                itemWidth: 70 * scale,
                itemHeight: 50 * scale,
                value: minuteValue.value,
                selectedTextStyle: _theme.textTheme.headline1,
                textStyle: _theme.textTheme.headline2,
                infiniteLoop: true,
                onChanged: (value) {
                  minuteValue.value = value;
                },
              ),
              Text('timer_minute'.tr, style: _theme.textTheme.subtitle1)
                  .marginOnly(right: 20 * scale),

              // 秒
              NumberPicker(
                minValue: 0,
                maxValue: 59,
                zeroPad: true,
                itemWidth: 70 * scale,
                itemHeight: 50 * scale,
                value: secondValue.value,
                selectedTextStyle: _theme.textTheme.headline1,
                textStyle: _theme.textTheme.headline2,
                infiniteLoop: true,
                onChanged: (value) {
                  secondValue.value = value;
                },
              ),
              Text(
                'timer_second'.tr,
                style: _theme.textTheme.subtitle1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
