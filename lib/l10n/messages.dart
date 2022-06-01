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
          'ringtone': '铃声',
          'dark_mode': '夜间模式',
          'lab': 'Simple实验室',
          'language': '语言',
          'check_updates': '检查更新',
          'about': '关于',
          'set_Language': "设置语言",
          'timer_hour': '时',
          'timer_minute': '分',
          'timer_second': '秒',
        },
        'en_US': {
          'timer': 'Timer',
          'setting': 'Settings',
          'stop_watch': 'StopWatch',
          'ringtone': 'Ringtone',
          'dark_mode': 'DarkMode',
          'lab': 'Simple Lab',
          'language': 'Language',
          'check_updates': 'Check updates',
          'about': 'About',
          'set_Language': "Set Language",
          'timer_hour': 'H',
          'timer_minute': 'M',
          'timer_second': 'S',
        }
      };
}
