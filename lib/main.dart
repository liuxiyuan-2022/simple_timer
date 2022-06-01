import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:simple_timer/l10n/messages.dart';
import 'package:simple_timer/pages/home_page.dart';
import 'package:simple_timer/style/app_theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //不加这个强制横/竖屏会报错
  SystemChrome.setPreferredOrientations([
    // 强制竖屏
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(), // 翻译类
      locale: const Locale('zh', 'CN'),
      debugShowCheckedModeBanner: false,
      darkTheme: appThemeDataDark,
      theme: appThemeDataLight,
      home: const HomePage(),
      onDispose: () {
        print('dis');
      },
    );
  }
}
