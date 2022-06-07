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

  /// 将毫秒转化为 分/秒/毫秒
  static String msformat(int ms) {
    var millisecond = (ms % 1000).truncate();
    var second = 0;
    var totalMinute = 0;
    var minute = 0;
    var result = "";
    var totalSecond = (ms / 1000).truncate(); // 3671
    if (totalSecond > 59) {
      // 总秒数大于59 需要计算总分钟 数
      second = (totalSecond % 60).truncate(); // 11
      totalMinute = (totalSecond / 60).truncate(); // 61
    } else {
      second = totalSecond;
    }
    if (totalMinute > 59) {
      minute = (totalMinute % 60).truncate(); // 1
    } else {
      minute = totalMinute;
    }

    result += minute.toString().padLeft(2, '0');
    result += ':' + second.toString().padLeft(2, '0');
    result += "." + millisecond.toString().padLeft(3, '0').substring(0, 2);

    return result;
  }
}
