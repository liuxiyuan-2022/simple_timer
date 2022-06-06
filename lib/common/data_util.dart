/// 数据类型转换
class DataUtil {
  /// 将小时 + 分 + 秒 转化单位为 秒
  static int timeToSecond(int h, int m, int s) {
    return h * 60 * 60 + m * 60 + s;
  }

  /// 将时间转换为字符串 0:30:1 => '00:30:01'
  static String timeToString(int h, int m, int s) {
    String result = h.toString().padLeft(2, '0') + ':';
    result += m.toString().padLeft(2, '0') + ':';
    result += s.toString().padLeft(2, '0');
    return result;
  }
}
