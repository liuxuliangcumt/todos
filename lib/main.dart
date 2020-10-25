import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todos/config/provider_config.dart';
import 'package:todos/generated/l10n.dart';

import 'model/global_model.dart';

void main() {
  // runApp(MyApp());
  runApp(ProviderConfig.getInstance().getGlobal(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context)..setContext(context);

    return MaterialApp(
      title: model.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      locale: model.currentLocale,
      home: getHomePage(model.goToLogin, model.enableSplashAnimation),
    );
  }

  Widget getHomePage(bool goToLogin, bool enableSplashAnimation) {
    /* if(goToLogin == null) return Container();
    if(enableSplashAnimation) return new SplashPage();
    return goToLogin ? ProviderConfig.getInstance().getLoginPage(isFirst: true)
        : ProviderConfig.getInstance().getMainPage();*/
    return ProviderConfig.getInstance().getMainPage();
  }
}
