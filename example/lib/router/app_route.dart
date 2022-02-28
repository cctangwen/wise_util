import 'package:example/pages/formatter/formatter_binding.dart';
import 'package:example/pages/formatter/formatter_view.dart';
import 'package:example/pages/home/home_binding.dart';
import 'package:example/pages/home/home_view.dart';
import 'package:example/pages/keyboard/keyboard_binding.dart';
import 'package:example/pages/keyboard/keyboard_view.dart';
import 'package:example/pages/multi_state/multi_state_binding.dart';
import 'package:example/pages/multi_state/multi_state_view.dart';
import 'package:example/pages/paged_load/paged_load_binding.dart';
import 'package:example/pages/paged_load/paged_load_view.dart';
import 'package:example/pages/pull_to_refresh/pull_to_refresh_binding.dart';
import 'package:example/pages/pull_to_refresh/pull_to_refresh_view.dart';
import 'package:example/pages/style/style_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoute {
  static const String pageHome = '/home';
  static const String pageStyle = '/style';
  static const String pageFormatter = '/formatter';
  static const String pageKeyboard = '/keyboard';
  static const String pageMultiState = '/multiState';
  static const String pagePullToRefresh = '/pullToRefresh';
  static const String pagePagedLoad = '/pagedLoad';

  static final List<GetPage> pages = [
    GetPage(
      name: pageHome,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: pageStyle,
      page: () => StylePage(),
    ),
    GetPage(
      name: pageFormatter,
      page: () => FormatterPage(),
      binding: FormatterBinding(),
    ),
    GetPage(
      name: pageKeyboard,
      page: () => KeyboardPage(),
      binding: KeyboardBinding(),
    ),
    GetPage(
      name: pageMultiState,
      page: () => MultiStatePage(),
      binding: MultiStateBinding(),
    ),
    GetPage(
      name: pagePullToRefresh,
      page: () => PullToRefreshPage(),
      binding: PullToRefreshBinding(),
    ),
    GetPage(
      name: pagePagedLoad,
      page: () => PagedLoadPage(),
      binding: PagedLoadBinding(),
    ),
  ];
}
