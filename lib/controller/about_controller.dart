import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:url_launcher/url_launcher.dart';

/// about页面控制器
class AboutController extends GetxController {
  var appName = ''.obs;

  /// 版本信息
  var version = ''.obs;

  /// 介绍
  var message = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initPackageInfo();
  }

  /// 初始化app信息
  void initPackageInfo() async {
    if (GetPlatform.isAndroid) {
      // version.value = androidInfo.version.toString();
      version.value = '1.0.0.120';
    } else {
      // version.value = iosInfo.systemVersion.toString();
    }
    message.value = 'about_page_message'.tr;
  }

  /// 访问项目GitHub网址
  void openGitHub() {
    final Uri _url = Uri.parse(
      'https://github.com/liuxiyuan-2022/simple_timer',
    );
    launchUrl(_url, mode: LaunchMode.externalNonBrowserApplication);
  }

  /// 访问GitHub主页
  void openGitHubHome() {
    final Uri _url = Uri.parse(
      'https://github.com/liuxiyuan-2022',
    );
    launchUrl(_url, mode: LaunchMode.externalNonBrowserApplication);
  }
}
