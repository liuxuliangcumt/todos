import 'package:flutter/cupertino.dart';

class GlobalModel extends ChangeNotifier {
  ///app的名字
  String appName = '一日';
  BuildContext context;

  ///当前语言
  List<String> currentLanguageCode = ['zh', 'CN'];
  String currentLanguage = '中文';
  Locale currentLocale;

  ///是否进入登录页
  bool goToLogin;

  ///是否开启首页动画
  bool enableSplashAnimation = false;

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      currentLocale = Locale(currentLanguageCode[0], currentLanguageCode[1]);
      refresh();
    }
  }

  void refresh() {
    notifyListeners();
  }
}
