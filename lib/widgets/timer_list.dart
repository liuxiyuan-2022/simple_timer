import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/common/get_notification.dart';
import 'package:simple_timer/controller/timer_controller.dart';

class TimerList extends GetView<TimerController> {
  const TimerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 使用update(['id']) 刷新GetBuilder()
    return GetBuilder(
      init: TimerController(),
      id: 'timerList',
      builder: (context) {
        return SizedBox(
          height: 120,
          child: GridView.builder(
            controller: controller.timerListController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 1.9,
            ),
            itemCount: controller.timerList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  controller.applyTimerListInfo(index);
                },
                onLongPress: () => GetNotification.showEditBar(index),
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.1),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.timerList[index][1],
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                      ).marginOnly(bottom: 3),
                      Text(
                        controller.timerList[index][0],
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ).marginOnly(left: 25, right: 25);
      },
    );
  }
}
