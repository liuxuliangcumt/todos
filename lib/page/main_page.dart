import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/generated/l10n.dart';
import 'package:todos/model/global_model.dart';
import 'package:todos/model/mainpage_model.dart';
import 'package:todos/widgets/animated_floating_button.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MainPageModel>(context);
    final globalModel = Provider.of<GlobalModel>(context);
    final size = MediaQuery.of(context).size;
    final canHideWidget = model.canHideWidget;
    return Container(
      decoration: model.logic.getBackground(globalModel),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(S.of(context).appName),
        ),
        floatingActionButton: GestureDetector(
          onDoubleTap: () {},
          child: AnimatedFloatingButton(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}
