import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_timer/controller/text_field_controller.dart';

class MainTextField extends GetView<TextFieldController> {
  const MainTextField({
    Key? key,
    this.autofocus,
  }) : super(key: key);

  /// 是否自动聚焦
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    Get.put(TextFieldController());
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
        autofocus: autofocus ?? false,
        textAlignVertical: TextAlignVertical.center, // 垂直居中对齐
        controller: controller.editController,
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
              controller.editController.clear();
            },
          ),
        ),
      ),
    );
  }
}
