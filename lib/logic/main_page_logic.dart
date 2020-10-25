import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todos/model/global_model.dart';
import 'package:todos/model/mainpage_model.dart';

class MainPageLogic {
  final MainPageModel _model;

  MainPageLogic(this._model);

  BoxDecoration getBackground(GlobalModel globalModel) {
    return BoxDecoration(color: Colors.pinkAccent);
  }
}
