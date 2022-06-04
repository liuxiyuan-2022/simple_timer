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

  /// 铃声播放路径列表
  var ringFromAssetList = [
    "assets/audio/ringtone_drip.mp3", // 滴答
    "assets/audio/ringtone_chords.mp3", // 音阶
    "assets/audio/ringtone_jingle.mp3", // 叮当
    "assets/audio/ringtone_light-steps.mp3", // 轻盈的步伐
    "assets/audio/ringtone_music-box.mp3", // 音乐盒
  ].obs;

  /// 当前默认铃声
  var defaultRing = DefaultRingtones.drip.obs;

  /// 当前默认铃声路径
  var defaultRingAsset = 'assets/audio/ringtone_drip.mp3'.obs;
  // /// 检查版本更新放DDos记数
  // var versionDDosCount = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    initDarkMode();
    initAppLanguage();
    initRingtone();
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

  /// 检查版本更新[点击]
  void checkVersion() {
    // ignore: dead_code
    if (false) {
      GetNotification.showToastSnakbar(
        'already_the_latest_version',
        minWidth: 135,
        maxWidth: 200,
      );
    } else {
      // Get.bottomSheet(bottomsheet)
      GetNotification.showCustomBottomSheet(
        title: 'version_update'.tr,
        message: 'Do you need to update to version 8.8.61',
      );
    }
  }

  /// app初始化时调用
  void initCheckUpdates() {}

  /// 切换铃声
  void changeRingtone(DefaultRingtones ringtone) async {
    defaultRing.value = ringtone;
    defaultRingAsset.value =
        ringFromAssetList[DefaultRingtones.values.indexOf(ringtone)];
    await prefs.setString('defaultRing', defaultRingAsset.value);
  }

  /// 初始化默认铃声
  void initRingtone() {
    defaultRingAsset.value =
        prefs.getString('defaultRing') ?? "assets/audio/ringtone_drip.mp3";
    int _ringIndex = ringFromAssetList.indexOf(defaultRingAsset.value);
    defaultRing.value = DefaultRingtones.values[_ringIndex];
  }
}

/// 语言列表 默认值[AppLanguage.zh_CN]
// ignore: constant_identifier_names
enum AppLanguage { zh_CN, en_US }

/// 铃声列表 默认值[DefaultRingtones.drip]
// ignore: constant_identifier_names
enum DefaultRingtones { drip, chords, jingle, light_steps, music_box }
