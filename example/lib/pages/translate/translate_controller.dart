import 'dart:async';

import 'package:get/get.dart';

class TranslateController extends GetxController {
  ///计时器
  Timer? _timer;

  ///倒计时时间
  int countDownTime = 0;

  final Rx<int> rxCountDownTime = Rx<int>(0);

  ///启动倒计时
  void _startTimer() {
    const oneSec = const Duration(seconds: 1); //间隔1秒
    _timer = new Timer.periodic(
      oneSec,
      (timer) {
        countDownTime = countDownTime + 1;
        rxCountDownTime.value = countDownTime;
        print("countDownTime:$countDownTime");
        update();
      },
    );
  }

  @override
  void onReady() {
    _startTimer();
    super.onReady();
  }

  @override
  void dispose() {
    if (null != _timer) _timer!.cancel();
    super.dispose();
  }
}
