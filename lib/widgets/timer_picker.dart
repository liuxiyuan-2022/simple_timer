import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:simple_timer/common/color_util.dart';
import 'package:simple_timer/controller/timer_controller.dart';

class TimerPicker extends GetView<TimerController> {
  const TimerPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _second = 0;
    int _minute = 0;
    int _hour = 0;

    ThemeData _theme = Theme.of(context).copyWith(
      textTheme: TextTheme(
        // selectedTextStyle
        headline1: const TextStyle(
          fontSize: 40,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),

        // textStyle
        headline2: TextStyle(
          fontSize: 22,
          color: ColorUtil.hex('#939ba3').withOpacity(.8),
        ),

        // 时分秒文字
        subtitle1: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w100,
          color: Colors.black,
        ),
      ),
    );

    return Obx(
      () => SizedBox(
        width: context.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 小时
                NumberPicker(
                  minValue: 0,
                  maxValue: 10,
                  zeroPad: true,
                  itemWidth: 70,

                  // 避免计时时继续刷新此组件
                  value: TimerController.to.isTiming.value
                      ? _hour
                      : TimerController.to.timerHour.value,
                  selectedTextStyle: _theme.textTheme.headline1,
                  textStyle: _theme.textTheme.headline2,
                  infiniteLoop: true,
                  onChanged: (value) {
                    _hour = value;
                    TimerController.to.updateTimerPicker(value, 'h');
                  },
                ),
                Text('时', style: _theme.textTheme.subtitle1)
                    .marginOnly(right: 20),

                // 分钟
                NumberPicker(
                  minValue: 0,
                  maxValue: 59,
                  zeroPad: true,
                  itemWidth: 70,
                  value: TimerController.to.isTiming.value
                      ? _minute
                      : TimerController.to.timerMinute.value,
                  selectedTextStyle: _theme.textTheme.headline1,
                  textStyle: _theme.textTheme.headline2,
                  infiniteLoop: true,
                  onChanged: (value) {
                    _minute = value;
                    TimerController.to.updateTimerPicker(value, 'm');
                  },
                ),
                Text('分', style: _theme.textTheme.subtitle1)
                    .marginOnly(right: 20),

                // 秒
                NumberPicker(
                  minValue: 0,
                  maxValue: 59,
                  zeroPad: true,
                  itemWidth: 70,
                  value: TimerController.to.isTiming.value
                      ? _second
                      : TimerController.to.timerSecond.value,
                  selectedTextStyle: _theme.textTheme.headline1,
                  textStyle: _theme.textTheme.headline2,
                  infiniteLoop: true,
                  onChanged: (value) {
                    _second = value;
                    TimerController.to.updateTimerPicker(value, 's');
                  },
                ),
                Text('秒', style: _theme.textTheme.subtitle1),
                // .marginOnly(right: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}