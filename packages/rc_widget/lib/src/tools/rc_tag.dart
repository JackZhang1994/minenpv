/*
* @overview: 工具-Tag标识
* @Author: rcc 
* @Date: 2022-11-28 11:30:51 
*/

class RcTag {
  RcTag._();

  /// Tag标识
  static String tag = '';

  /// 创建Tag标识
  static void initTag() {
    tag = DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// 更新Tag标识
  static void updateTag() {
    tag = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
