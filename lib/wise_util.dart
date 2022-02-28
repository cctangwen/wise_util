import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/util/http/http_manager.dart';
import '/util/screen/screen_util.dart';
import '/util/sp_util.dart';

// export 'config/wise_config.dart';
// export 'res/wise_color.dart';
// export 'res/wise_localizations.dart';
// export 'res/wise_style.dart';
// export 'util/formatter/currency_formatter.dart';
// export 'util/formatter/datetime_formatter.dart';
// export 'util/formatter/number_formatter.dart';
// export 'util/http/http_manager.dart';
// export 'util/http/http_response_data.dart';
// export 'util/permission_util.dart';
// export 'util/screen/screen_size_extension.dart';
// export 'util/screen/screen_util.dart';
// export 'util/sp_util.dart';
// export 'widget/wise_box.dart';
// export 'widget/wise_button.dart';
// export 'widget/wise_digital_keyboard.dart';
// export 'widget/wise_loading.dart';
// export 'widget/wise_multi_state/wise_multi_state_widget.dart';
// export 'widget/wise_pull_to_refresh.dart';
// export 'widget/wise_snackbar.dart';
// export 'wise_util.dart';

class WiseUtil {
  ///初始化依赖
  static Future<void> initDependency() async {
    ///初始化SP
    await SpUtil.getInstance();

    ///注入HttpManager
    Get.put(HttpManager());
  }

  ///屏幕适配初始化
  static void initScreen(BuildContext context) {
    ScreenUtil.init(context);
  }
}
