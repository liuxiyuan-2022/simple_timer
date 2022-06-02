import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_timer/common/get_notification.dart';
import 'package:simple_timer/style/app_theme_data.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  late SharedPreferences prefs;

  /// 夜间模式
  var isDarkMode = false.obs;

  /// Locale标签列表 ['zh_CN', 'en_US']
  var languageTagList = ['zh_CN', 'en_US'];

  /// app语言名称列表 ['简体中文', 'English']
  var languageTitleList = ['简体中文', 'English'].obs;

  /// 当前app语言 默认值: [AppLanguage.zh_CN]
  var language = AppLanguage.zh_CN.obs;

  /// 是否是最新版本
  var isLatestVersion = false.obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    initDarkMode();
    initAppLanguage();
    // checkUpdates();
  }

  /// 切换深色主题
  void changeMode(bool _isDarkMode) async {
    isDarkMode.value = _isDarkMode;

    Get.changeTheme(_isDarkMode ? appThemeDataDark : appThemeDataLight);
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  /// 初始化深色主题
  void initDarkMode() {
    bool _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    changeMode(_isDarkMode);
  }

  /// 切换语言
  void changeLanguage(AppLanguage appLanguage) async {
    String _locale = languageTagList[AppLanguage.values.indexOf(appLanguage)];
    language.value = appLanguage;
    Get.updateLocale(
      Locale(_locale.split('_')[0], _locale.split('_')[1]),
    );

    await prefs.setString('language', _locale);
  }

  /// 初始化App语言设置
  void initAppLanguage() {
    // 默认中文: [zh_CN]
    String _localeTag = prefs.getString('language') ?? 'zh_CN';
    language.value = AppLanguage.values[languageTagList.indexOf(_localeTag)];
    Get.updateLocale(
      Locale(_localeTag.split('_')[0], _localeTag.split('_')[1]),
    );
  }

  /// 检查版本更新
  void checkUpdates() async {
    if (true) {
      GetNotification.showToastSnakbar(
        'already_the_latest_version',
        minWidth: 135,
        maxWidth: 200,
      );
    } else {}
  }
}

/// 语言列表 默认值[AppLanguage.zh_CN]
// ignore: constant_identifier_names
enum AppLanguage { zh_CN, en_US }
