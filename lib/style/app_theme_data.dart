import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:simple_timer/common/color_util.dart';

/* 调色板
  ColorUtil.hex("#939ba3"),
  ColorUtil.hex("#ef5562"),
  ColorUtil.hex("#34384a"),
  Colors.grey[400],
*/

ThemeData appThemeDataLight = ThemeData(
  fontFamily: 'Harmony',

  // 去除安卓样式中的水波纹
  platform: TargetPlatform.iOS,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,

  // 主要颜色(文本)
  primaryColor: Colors.black,

  // 背景颜色
  scaffoldBackgroundColor: Colors.white,

  // Switch、Radio和Checkbox等部件的活动状态的颜色。
  toggleableActiveColor: ColorUtil.hex('#ef5562'),

  // 顶部导航栏主题
  appBarTheme: const AppBarTheme(
    // 手机状态栏样式
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // 图标黑色
      statusBarColor: Colors.transparent, //背景透明
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
  ),

  // 图标主题
  iconTheme: const IconThemeData(color: Colors.grey),

  // 卡片颜色主题
  cardColor: Colors.white,
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    shadowColor: Colors.grey.withOpacity(.2),
    elevation: 5,
  ),
);

ThemeData appThemeDataDark = appThemeDataLight.copyWith(
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: appThemeDataLight.appBarTheme.copyWith(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  // cardColor: Colors.grey.withOpacity(.1),
  cardColor: ColorUtil.hex("#141414"),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    shadowColor: Colors.transparent,
    elevation: 10,
  ),
);
