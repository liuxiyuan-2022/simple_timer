import 'package:get/get.dart';

class Messages extends Translations {
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
        },
        'en_US': {
          'timer': 'Timer',
          'setting': '设置',
        }
      };
}
