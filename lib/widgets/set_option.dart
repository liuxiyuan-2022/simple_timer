// ignore_for_file: constant_identifier_names

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SetOption extends StatelessWidget {
  const SetOption({
    Key? key,
    required this.leading,
    required this.title,
    this.subtitle = "",
    this.actions = const [],
    this.onTap,
    this.showArrowRight = true,
    this.iconStyle = SetOptionIconStyle.icon,
  }) : super(key: key);

  final IconData leading;
  final String title;
  final String subtitle;
  final List<Widget> actions;
  final Function()? onTap;
  final bool showArrowRight;

  /// 使用[SetOptionIconStyle.faIcon]或 [SetOptionIconStyle.icon] 作为图标样式
  /// [SetOptionIconStyle.icon]为默认值
  final SetOptionIconStyle iconStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*
              图标外嵌套Sizedbox()是为了防止FaIcon图标之间的宽高不统一,出现多行title不对齐.
              也可以使用Icon嵌套FontAwesomeIcons来解决:  Icon(FontAwesomeIcons.xxx)
              这会约束FaIcon的宽高并显示超出范围的部分. 
            */
            SizedBox(
              width: 20,
              child: iconStyle == SetOptionIconStyle.faIcon
                  ? FaIcon(
                      leading,
                      color: Theme.of(context).toggleableActiveColor,
                      size: 20,
                    )
                  : Icon(
                      leading,
                      color: Theme.of(context).toggleableActiveColor,
                      size: 20,
                    ),
            ).marginOnly(right: 15),
            Text(
              title.tr,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            const Expanded(child: SizedBox(width: double.maxFinite)),
            // widget,
            Row(children: actions),
            Visibility(
              visible: showArrowRight,
              child: Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey[400],
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 当前图标使用FontAwesome或Icons
enum SetOptionIconStyle { faIcon, icon }
