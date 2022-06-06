import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_timer/controller/timer_controller.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({Key? key}) : super(key: key);

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this); //添加观察者
  }

  ///应用尺寸改变时回调，例如旋转、键盘弹出、收缩
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (MediaQuery.of(Get.context!).viewInsets.bottom == 0) {
        /// 键盘收起时
        TimerController.to.isShowKeyboard.value = false;
      } else {
        TimerController.to.isShowKeyboard.value = true;
      }
    });
  }

  final FocusNode _focusNodeUser = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 6,
            color: Colors.grey.withOpacity(.3),
          ),
        ),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center, // 垂直居中对齐
        controller: TimerController.to.editController,
        focusNode: _focusNodeUser,
        cursorColor:
            Theme.of(context).toggleableActiveColor.withOpacity(.3), // 光标颜色
        cursorWidth: 2,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).primaryColor,
          textBaseline: TextBaseline.alphabetic,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(15) //限制长度
        ],
        decoration: InputDecoration(
          isDense: true,
          hintText: 'input_content'.tr,
          hintStyle: const TextStyle(
            color: Colors.grey,
            textBaseline: TextBaseline.alphabetic,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.only(left: 10),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(Icons.clear, color: Colors.grey[400], size: 20),
            onPressed: () {
              // 清空字符串
              TimerController.to.editController.clear();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 销毁观察者
    WidgetsBinding.instance!.removeObserver(this);
    TimerController.to.isShowKeyboard.value = false;
    // 初始化控制器
    TimerController.to.editController.clear();
    super.dispose();
  }
}
