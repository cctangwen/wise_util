import 'dart:math';

class RandomUtil {
  static String number(int length) {
    String num = "";
    var random = Random();
    for (int index = 0; index < length; index++) {
      num = "$num${random.nextInt(10)}";
    }
    return num;
  }
}
