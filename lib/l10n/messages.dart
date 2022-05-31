import 'package:get/get.dart';

class Messages extends Translations {
  /*
  如果需要新增语言, 需同时在settings_controller.dart的
  [languageTagList] [languageTitleList] [AppLanguage] 中添加对应元素
*/
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          'timer': '计时器',
          'setting': '设置',
          'stop_watch': '秒表',
          'notification_bell': '通知铃声',
          'dark_mode': '夜间模式',
          'lab': 'Simple实验室',
          'language': '语言',
          'check_updates': '检查更新',
          'about': '关于',
          'set_Language': "设置语言",
        },
        'en_US': {
          'timer': 'Timer',
          'setting': 'Settings',
          'stop_watch': 'StopWatch',
          'notification_bell': 'Check updates',
          'dark_mode': 'DarkMode',
          'lab': 'Simple Lab',
          'language': 'Language',
          'check_updates': 'Check updates',
          'about': 'About',
          'set_Language': "Set Language",
        }
      };
}
