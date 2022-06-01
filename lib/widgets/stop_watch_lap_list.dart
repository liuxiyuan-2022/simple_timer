import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/controller/stop_watch_controller.dart';

/// 单圈计时列表
class StopWatchLapList extends GetView<StopWatchController> {
  const StopWatchLapList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(StopWatchController());

    TextStyle _tetxStyle = TextStyle(
      fontSize: 16,
      height: 1.1,
      color: Theme.of(context).primaryColor.withOpacity(.5),
    );

    return Obx(
      () => Visibility(
        visible: controller.isTiming.value || controller.lapTimeList.isNotEmpty
            ? true
            : false,
        child: SizedBox(
          height: 250,
          width: context.width - 125,
          child: ListView.builder(
            itemCount: controller.lapTimeList.length,
            itemExtent: 40,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 序号
                  Text(
                    (controller.lapTimeList.length - index)
                        .toString()
                        .padLeft(2, '0'),
                    style: _tetxStyle.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Expanded(child: SizedBox(width: double.maxFinite)),

                  // 单圈时间间隔
                  Text('+${controller.lapIntervalList[index]}',
                      style: _tetxStyle),
                  const Expanded(child: SizedBox(width: double.maxFinite)),

                  // 单圈时间
                  Text(
                    controller.lapTimeList[index].split('.')[0] + '.',
                    style: _tetxStyle.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    controller.lapTimeList[index].split('.')[1],
                    style: _tetxStyle,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
