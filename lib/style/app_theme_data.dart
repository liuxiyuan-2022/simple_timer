import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

/* 调色板
  ColorUtil.hex("#939ba3"),
  ColorUtil.hex("#ef5562"),
  ColorUtil.hex("#34384a"),

*/

ThemeData appThemeDataLight = ThemeData(
  fontFamily: 'Harmony',
  platform: TargetPlatform.iOS, // 去除安卓样式中的水波纹
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
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
);

ThemeData appThemeDataDark = appThemeDataLight.copyWith();
