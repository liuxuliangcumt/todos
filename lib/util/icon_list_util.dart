import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todos/config/keys.dart';
import 'package:todos/json/color_bean.dart';
import 'package:todos/json/task_icon_bean.dart';
import 'package:todos/util/shared_util.dart';
import 'package:todos/util/theme_util.dart';

class IconListUtil {
  static IconListUtil _instance;

  static IconListUtil getInstance() {
    if (_instance == null) {
      _instance = IconListUtil._internal();
    }
    return _instance;
  }

  IconListUtil._internal();

  List<TaskIconBean> getDefaultTaskIcons(BuildContext context) {
    return [
      TaskIconBean(
          taskName: 'music',
          iconBean: IconBean.fromIconData(Icons.music_note),
          colorBean: ColorBean.fromColor(MyThemeColor.coffeeColor)),
      TaskIconBean(
          taskName: 'game',
          iconBean: IconBean.fromIconData(Icons.videogame_asset),
          colorBean: ColorBean.fromColor(MyThemeColor.cyanColor)),
      TaskIconBean(
          taskName: 'read',
          iconBean: IconBean.fromIconData(Icons.book),
          colorBean: ColorBean.fromColor(MyThemeColor.defaultColor)),
      TaskIconBean(
          taskName: 'sports',
          iconBean: IconBean.fromIconData(Icons.directions_run),
          colorBean: ColorBean.fromColor(MyThemeColor.greenColor)),
      TaskIconBean(
          taskName: 'travel',
          iconBean: IconBean.fromIconData(Icons.drive_eta),
          colorBean: ColorBean.fromColor(MyThemeColor.darkColor)),
      TaskIconBean(
          taskName: "work",
          iconBean: IconBean.fromIconData(Icons.work),
          colorBean: ColorBean.fromColor(MyThemeColor.blueGrayColor)),
    ];
  }

  Future<List<TaskIconBean>> getIconWithCache(BuildContext context) async {
    List<String> strings =
        await SharedUtil.instance.readList(Keys.taskIconBeans);
    List<TaskIconBean> list = [];
    for (var o in strings) {
      final data = jsonDecode(o);
      TaskIconBean taskIconBean = TaskIconBean.fromMap(data);
      list.add(taskIconBean);
    }
    final hasSaveDefaultIcons =
        await SharedUtil.instance.getBoolean(Keys.hasSavedDefaultIcons) ??
            false;
    List<TaskIconBean> defaultList = [];
    if (!hasSaveDefaultIcons) {
      defaultList = getDefaultTaskIcons(context);
      await SharedUtil.instance.saveBoolean(Keys.hasSavedDefaultIcons, true);
      List<String> defaultIcons = [];
      for (var defaultIcon in defaultList) {
        defaultIcons.add(jsonEncode(defaultIcon.toMap()));
      }
      await SharedUtil.instance
          .saveStringList(Keys.taskIconBeans, defaultIcons + strings);
    }
    return List.from(defaultList + list);
  }
}
