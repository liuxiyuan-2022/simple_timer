import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// BottomSheet外框样式
class BottomSheetBox extends StatelessWidget {
  const BottomSheetBox({
    Key? key,
    this.children = const <Widget>[],
    this.boxShadow,
    this.direction = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding,
  }) : super(key: key);

  final List<Widget> children;
  final List<BoxShadow>? boxShadow;
  final Axis direction;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.fromLTRB(25, 25, 25, 25),
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 25),
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        boxShadow: boxShadow ?? [],
      ),
      child: Flex(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        direction: direction,
        children: children,
      ),
    );
  }
}
