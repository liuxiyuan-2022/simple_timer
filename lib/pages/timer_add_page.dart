import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_timer/widgets/timer_picker.dart';

class TimerAddPage extends StatelessWidget {
  const TimerAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            // TimerPicker(),
          ],
        ),
      ),
    );
  }
}
