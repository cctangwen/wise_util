import 'package:example/generated/l10n.dart';
import 'package:example/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:wise_util/res/wise_localizations.dart';
import 'package:wise_util/res/wise_theme.dart';
import 'package:wise_util/wise_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///强制应用竖屏显示
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  ///透明沉浸式状态栏
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.black,
  ));

  await WiseUtil.initDependency();

  runApp(GetMaterialApp(
    ///主题样式
    theme: getLightThemeData(Colors.red),

    ///深色模式主题样式
    darkTheme: getDarkThemeData(Colors.red),

    ///初始化页面
    initialRoute: AppRoute.pageHome,

    ///指定应用路由
    getPages: AppRoute.pages,

    ///国际化
    localizationsDelegates: [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      WiseLocalizations.delegate
    ],
    supportedLocales: S.delegate.supportedLocales,

    ///过渡动画
    defaultTransition: Transition.cupertino,

    ///点击空白隐藏键盘
    builder: (context, child) {
      child = Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: child,
        ),
      );

      ///初始化屏幕适配
      WiseUtil.initScreen(context);

      ///不随系统改变字体大小
      child = MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child);

      return child;
    },
  ));
}
