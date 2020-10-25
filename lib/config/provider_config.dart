import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todos/model/global_model.dart';
import 'package:todos/model/mainpage_model.dart';
import 'package:todos/page/main_page.dart';

class ProviderConfig {
  static ProviderConfig _instance;

  static ProviderConfig getInstance() {
    if (_instance == null) {
      _instance = ProviderConfig._internal();
    }
    return _instance;
  }

  ProviderConfig._internal();

  ///全局provider
  ChangeNotifierProvider<GlobalModel> getGlobal(Widget child) {
    return ChangeNotifierProvider.value(
      value: GlobalModel(),
      child: child,
    );
  }

  ///MainPage
  ChangeNotifierProvider<MainPageModel> getMainPage() {
    return ChangeNotifierProvider.value(
      value: MainPageModel(),
      child: MainPage(),
    );
  }
}
