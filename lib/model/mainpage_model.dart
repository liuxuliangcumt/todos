import 'package:flutter/cupertino.dart';
import 'package:todos/logic/main_page_logic.dart';

class MainPageModel extends ChangeNotifier {
  ///用于在透明模式下，打开任务卡片时，隐藏头像等内容
  bool canHideWidget = false;
  MainPageLogic logic;

  MainPageModel() {
    logic = MainPageLogic(this);
  }
}
