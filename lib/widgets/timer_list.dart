import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_timer/common/get_notification.dart';
import 'package:simple_timer/controller/timer_list_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TimerList extends GetView<TimerListController> {
  const TimerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
// 使用update(['id']) 刷新GetBuilder()
    final pageController = PageController();
    return GetBuilder(
        init: TimerListController(),
        id: 'timerList',
        builder: (_) {
          return Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: controller.pageCount.value,
                    itemBuilder: (BuildContext context, int pageIndex) {
                      int listCount = 0; // 当前page的预设个数
                      // 判断是否为最后一页
                      if (pageIndex != controller.pageCount.value - 1) {
                        listCount = 6;
                      } else {
                        listCount = controller.timerList.length - pageIndex * 6;
                      }
                      return GridView.builder(
                        controller: controller.listScrollController,
                        itemCount: listCount,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          // childAspectRatio: 1 / 1.9,
                          mainAxisExtent: (context.width - 70) / 3,
                        ),
                        itemBuilder: (BuildContext context, int _index) {
                          int listIndex = pageIndex * 6; // 当前页面的预设索引值初始值
                          return controller.timerList[listIndex + _index][0] ==
                                  'add'
                              ? InkWell(
                                  onTap: () {
                                    // 显示 添加计时器预设
                                    GetNotification.showAddTimerBottomSheet();

                                    // animateController.forward();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    child: const Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.plus,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    controller
                                        .applyTimerListInfo(listIndex + _index);
                                    printInfo(
                                        info:
                                            '${(TimerListController.to.timerList.length / 6).ceil()}');
                                  },
                                  onLongPress: () =>
                                      GetNotification.showEditBar(
                                          listIndex + _index),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller
                                              .timerList[listIndex + _index][1],
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          textAlign: TextAlign.center,
                                        ).marginOnly(bottom: 3),
                                        Text(
                                          controller
                                              .timerList[listIndex + _index][0],
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        },
                      ).marginOnly(left: 25, right: 25);
                    },
                  ),
                ),

                // 当page页面小于2时, 隐藏指示器
                AnimatedOpacity(
                  opacity: controller.pageCount.value == 1 ? 0.0 : 1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: controller.pageCount.value,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Theme.of(context).primaryColor,
                      dotColor: Colors.grey.withOpacity(.3),
                      type: WormType.thin,
                    ),
                  ).marginOnly(top: 15),
                ),
              ],
            ),
          );
          // return GetBuilder(
          //   init: TimerListController(),
          //   id: 'timerList',
          //   builder: (_) {
          //     return SizedBox(
          //       height: 120,
          //       child: GridView.builder(
          //         controller: controller.listScrollController,
          //         itemCount: controller.timerList.length,
          //         scrollDirection: Axis.horizontal,
          //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //           mainAxisSpacing: 10,
          //           crossAxisSpacing: 10,
          //           // childAspectRatio: 1 / 1.9,
          //           mainAxisExtent: (context.width - 70) / 3,
          //         ),
          //         itemBuilder: (BuildContext context, int index) {
          //           return controller.timerList[index][0] == 'add'
          //               ? InkWell(
          //                   onTap: () {
          //                     // 显示 添加计时器预设
          //                     GetNotification.showAddTimerBottomSheet();
          //                     // animateController.forward();
          //                   },
          //                   child: Container(
          //                     padding: const EdgeInsets.only(left: 5, right: 5),
          //                     decoration: BoxDecoration(
          //                       color: Colors.grey.withOpacity(.1),
          //                       borderRadius:
          //                           const BorderRadius.all(Radius.circular(15)),
          //                     ),
          //                     child: const Center(
          //                       child: FaIcon(
          //                         FontAwesomeIcons.plus,
          //                         color: Colors.grey,
          //                       ),
          //                     ),
          //                   ),
          //                 )
          //               : InkWell(
          //                   onTap: () {
          //                     controller.applyTimerListInfo(index);
          //                   },
          //                   onLongPress: () => GetNotification.showEditBar(index),
          //                   child: Container(
          //                     padding: const EdgeInsets.only(left: 5, right: 5),
          //                     decoration: BoxDecoration(
          //                       color: Colors.grey.withOpacity(.1),
          //                       borderRadius:
          //                           const BorderRadius.all(Radius.circular(15)),
          //                     ),
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         Text(
          //                           controller.timerList[index][1],
          //                           style: TextStyle(
          //                             color: Theme.of(context).primaryColor,
          //                             fontSize: 12,
          //                             overflow: TextOverflow.ellipsis,
          //                           ),
          //                           textAlign: TextAlign.center,
          //                         ).marginOnly(bottom: 3),
          //                         Text(
          //                           controller.timerList[index][0],
          //                           style: TextStyle(
          //                             color: Theme.of(context).primaryColor,
          //                             fontSize: 12,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 );
          //         },
          //       ),
          //     ).marginOnly(left: 25, right: 25);
          //   },
          // );
        });
  }
}
