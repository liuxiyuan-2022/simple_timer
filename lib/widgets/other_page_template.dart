import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherPageTemplate extends StatelessWidget {
  const OtherPageTemplate({
    Key? key,
    required this.appTitle,
    required this.body,
  }) : super(key: key);

  final String appTitle;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Theme.of(context).primaryColor,
            size: 40,
          ),
        ).marginOnly(left: 10),
        title: Text(appTitle),
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
          height: 1.1,
        ),
      ),
      body: SafeArea(
        child: body.marginOnly(top: 20),
      ),
    );
  }
}
