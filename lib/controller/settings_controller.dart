import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_timer/style/app_theme_data.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  late SharedPreferences prefs;

  // 夜间模式
  var isDarkMode = false.obs;

  // 语言
  var languageTag = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    initDarkMode();
    initAppLanguage();
  }

  // 切换深色主题
  void changeMode(bool _isDarkMode) async {
    isDarkMode.value = _isDarkMode;

    Get.changeTheme(_isDarkMode ? appThemeDataDark : appThemeDataLight);
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  // 初始化深色主题
  void initDarkMode() {
    bool _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    changeMode(_isDarkMode);
  }

  // 切换语言
  void changeLanguage(AppLanguage appLanguage) async {
    late String _locale;
    switch (appLanguage) {
      case AppLanguage.zh_CN:
        _locale = 'zh_CN';
        languageTag.value = '简体中文';
        break;
      case AppLanguage.en_US:
        _locale = 'en_US';
        languageTag.value = 'Engilsh';
        break;
      default:
    }
    Get.updateLocale(
      Locale(_locale.split('_')[0], _locale.split('_')[1]),
    );
    await prefs.setString('language', _locale);
  }

  // 初始化App语言设置
  void initAppLanguage() {
    /// 默认中文: [zh_CN]
    String _appLanguage = prefs.getString('language') ?? 'zh_CN';
    Get.updateLocale(
      Locale(_appLanguage.split('_')[0], _appLanguage.split('_')[1]),
    );

    switch (_appLanguage) {
      case 'zh_CN':
        languageTag.value = '简体中文';
        break;
      case 'en_US':
        languageTag.value = 'English';
        break;
      default:
    }
  }
}

/// 语言列表 默认值[AppLanguage.zh_CN]
// ignore: constant_identifier_names
enum AppLanguage { zh_CN, en_US }
