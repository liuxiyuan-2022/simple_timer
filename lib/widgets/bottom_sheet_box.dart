import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// BottomSheet外框样式
class BottomSheetBox extends StatelessWidget {
  const BottomSheetBox({
    Key? key,
    this.children = const <Widget>[],
  }) : super(key: key);

  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 40, 25, 25),
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 25),
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
