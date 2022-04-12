import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WiseLocalizations {
  final Locale locale;

  WiseLocalizations(this.locale);

  Map<String, WiseString> values = {
    'en': EnWiseString(),
    'zh': ChWiseString(),
    'fr': FrWiseString(),
    'ja': JpWiseString(),
  };

  WiseString? get currentLocalization {
    if (values.containsKey(locale.languageCode)) {
      return values[locale.languageCode];
    }
    return values["en"];
  }

  static const WiseLocalizationsDelegate delegate = WiseLocalizationsDelegate();

  static WiseLocalizations? of(BuildContext context) {
    return Localizations.of(context, WiseLocalizations);
  }
}

class WiseLocalizationsDelegate
    extends LocalizationsDelegate<WiseLocalizations> {
  const WiseLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'zh',
      'fr',
      'ja',
    ].contains(locale.languageCode);
  }

  @override
  Future<WiseLocalizations> load(Locale locale) {
    return SynchronousFuture<WiseLocalizations>(WiseLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<WiseLocalizations> old) {
    return false;
  }
}

abstract class WiseString {
  ///Loading加载框默认描述
  late String loading;

  ///Snacker默认标题
  late String error;

  ///网络错误提示
  late String networkError;

  ///应用更新对话框标题
  late String appUpdateDialogTitle;

  ///应用更新对话框取消按钮
  late String appUpdateDialogCancel;

  ///应用更新对话框更新按钮
  late String appUpdateDialogUpdate;

  ///OK按钮
  late String ok;

  ///多状态页面-无数据
  late String multiStateNoData;

  ///多状态页面-无网络
  late String multiStateNoNetwork;

  ///下拉刷新-松开刷新
  late String refreshRelease;

  ///下拉刷新-刷新中
  late String refreshRefreshing;

  ///下拉刷新-刷新失败
  late String refreshFailed;

  ///下拉刷新-刷新成功
  late String refreshCompleted;

  ///下拉刷新-下拉刷新
  late String refreshIdle;

  ///上拉加载-加载中
  late String refreshLoadLoading;

  ///上拉加载-没有数据了
  late String refreshLoadNoData;

  ///上拉加载-加载失败
  late String refreshLoadFail;

  ///上拉加载-上拉加载更多
  late String refreshLoadIdle;

  ///上拉加载-松开加载
  late String refreshLoadCanLoading;

  ///下载中...
  late String downloading;

  ///请求权限-标题
  late String requestPermissionTitle;

  ///请求权限-存储权限下载安装包
  late String requestStoragePermissionToDownload;

  ///请求权限-设置按钮
  late String requestPermissionButton;

  ///选择地区号-标题
  late String selectAreaCodeTitle;

  ///选择地区号-搜索
  late String selectAreaCodeSearch;
}

class EnWiseString implements WiseString {
  @override
  String loading = "Loading...";

  @override
  String error = "Error";

  @override
  String networkError = "Network error, please check the network";

  @override
  String appUpdateDialogTitle = "Discover new version";

  @override
  String appUpdateDialogCancel = "Later";

  @override
  String appUpdateDialogUpdate = "Update";

  @override
  String ok = "OK";

  @override
  String multiStateNoData = "No Data";

  @override
  String multiStateNoNetwork = "Network error, please check the network";

  @override
  String refreshRelease = "Release to refresh";

  @override
  String refreshRefreshing = "Refreshing...";

  @override
  String refreshFailed = "Refresh failed";

  @override
  String refreshCompleted = "Refresh completed";

  @override
  String refreshIdle = "Pull down refresh";

  @override
  String refreshLoadLoading = "Loading...";

  @override
  String refreshLoadNoData = "No more data";

  @override
  String refreshLoadFail = "Load Failed";

  @override
  String refreshLoadIdle = "Pull up load more";

  @override
  String refreshLoadCanLoading = "Release to load more";

  @override
  String downloading = "Downloading...";

  @override
  String requestPermissionTitle = "Permission required";

  @override
  String requestPermissionButton = "Go Settings";

  @override
  String requestStoragePermissionToDownload =
      "Please open the storage permission first to download";

  @override
  String selectAreaCodeTitle = "Select Country/Region";

  @override
  String selectAreaCodeSearch = "Search";
}

class ChWiseString implements WiseString {
  @override
  String loading = "加载中...";

  @override
  String error = "错误";

  @override
  String networkError = "网络错误，请检查网络";

  @override
  String appUpdateDialogTitle = "发现新版本";

  @override
  String appUpdateDialogCancel = "稍后";

  @override
  String appUpdateDialogUpdate = "更新";

  @override
  String ok = "确定";

  @override
  String multiStateNoData = "无数据";

  @override
  String multiStateNoNetwork = "网络错误，请检查网络";

  @override
  String refreshRelease = "松开刷新";

  @override
  String refreshRefreshing = "刷新中...";

  @override
  String refreshFailed = "刷新失败";

  @override
  String refreshCompleted = "刷新完成";

  @override
  String refreshIdle = "下拉刷新";

  @override
  String refreshLoadLoading = "加载中...";

  @override
  String refreshLoadNoData = "没有更多数据";

  @override
  String refreshLoadFail = "加载失败";

  @override
  String refreshLoadIdle = "上拉加载更多";

  @override
  String refreshLoadCanLoading = "松开加载更多";

  @override
  String downloading = "下载中...";

  @override
  String requestPermissionTitle = "需要权限";

  @override
  String requestPermissionButton = "去设置";

  @override
  String requestStoragePermissionToDownload = "请先开启应用存储权限，以便下载安装包";

  @override
  String selectAreaCodeTitle = "选择国家/地区";

  @override
  String selectAreaCodeSearch = "搜索";
}

class JpWiseString implements WiseString {
  @override
  String loading = "ロード中...";

  @override
  String error = "エラー";

  @override
  String networkError = "ネットワークエラー、ネットワークを確認してください";

  @override
  String appUpdateDialogTitle = "新しいバージョンの検出";

  @override
  String appUpdateDialogCancel = "あとで";

  @override
  String appUpdateDialogUpdate = "更新";

  @override
  String ok = "OK";

  @override
  String multiStateNoData = "データなし";

  @override
  String multiStateNoNetwork = "ネットワークエラー、ネットワークを確認してください";

  @override
  String refreshRelease = "リフレッシュを解除";

  @override
  String refreshRefreshing = "更新中...";

  @override
  String refreshFailed = "更新に失敗しました";

  @override
  String refreshCompleted = "更新完了";

  @override
  String refreshIdle = "ドロップダウン・リフレッシュ";

  @override
  String refreshLoadLoading = "ロード中...";

  @override
  String refreshLoadNoData = "これ以上のデータ";

  @override
  String refreshLoadFail = "負荷失敗";

  @override
  String refreshLoadIdle = "プルアップ";

  @override
  String refreshLoadCanLoading = "より多くの負荷を解放する";

  @override
  String downloading = "ダウンロード中...";

  @override
  String requestPermissionTitle = "権限が必要です";

  @override
  String requestPermissionButton = "設定を解除";

  @override
  String requestStoragePermissionToDownload = "保存許可を最初にダウンロードしてください";

  @override
  String selectAreaCodeTitle = "国または地域";

  @override
  String selectAreaCodeSearch = "検索";
}

class FrWiseString implements WiseString {
  @override
  String loading = "Chargement en cours...";

  @override
  String error = "Erreur";

  @override
  String networkError = "Erreur réseau, veuillez vérifier le réseau";

  @override
  String appUpdateDialogTitle = "Nouvelle version trouvée";

  @override
  String appUpdateDialogCancel = "Plus tard,";

  @override
  String appUpdateDialogUpdate = "Mise à jour";

  @override
  String ok = "D'accord.";

  @override
  String multiStateNoData = "Aucune donnée disponible";

  @override
  String multiStateNoNetwork = "Erreur réseau, veuillez vérifier le réseau";

  @override
  String refreshRelease = "Desserrer le rafraîchissement";

  @override
  String refreshRefreshing = "Rafraîchir...";

  @override
  String refreshFailed = "Échec de la mise à jour";

  @override
  String refreshCompleted = "Rafraîchir terminé";

  @override
  String refreshIdle = "Rafraîchir la liste déroulante";

  @override
  String refreshLoadLoading = "Chargement en cours...";

  @override
  String refreshLoadNoData = "Plus de données";

  @override
  String refreshLoadFail = "Échec du chargement";

  @override
  String refreshLoadIdle = "Encore un peu.";

  @override
  String refreshLoadCanLoading = "Libérer pour charger plus";

  @override
  String downloading = "Téléchargement en cours...";

  @override
  String requestPermissionTitle = "Autorisation requise";

  @override
  String requestPermissionButton = "Pour définir";

  @override
  String requestStoragePermissionToDownload =
      "Veuillez d'abord ouvrir les permissions de stockage pour le téléchargement";

  @override
  String selectAreaCodeTitle = "Sélectionner un pays";

  @override
  String selectAreaCodeSearch = "Recherche";
}
