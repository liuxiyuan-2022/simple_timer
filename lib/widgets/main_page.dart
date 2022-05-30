import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends GetView {
  const MainPage({
    Key? key,
    required this.child,
    this.appBarTitle = "",
    this.appBarActions = const [],
  }) : super(key: key);

  final Widget child;
  final String appBarTitle;
  final List<Widget> appBarActions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          '| ' + appBarTitle,
          style: TextStyle(
            fontSize: 22,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ).marginOnly(left: 10),
        actions: appBarActions,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SafeArea(
        child: child.marginOnly(top: 20),
      ),
    );
  }
}
