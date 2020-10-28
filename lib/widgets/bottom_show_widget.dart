import 'dart:math';

import 'package:circle_list/circle_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todos/config/provider_config.dart';
import 'package:todos/json/color_bean.dart';
import 'package:todos/json/task_icon_bean.dart';

class BottomShowWidget extends StatefulWidget {
  final VoidCallback onExit;
  final List<TaskIconBean> taskIconBeans;

  BottomShowWidget({this.onExit, this.taskIconBeans});

  @override
  _BottomShowWidgetState createState() => _BottomShowWidgetState();
}

class _BottomShowWidgetState extends State<BottomShowWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  List<TaskIconBean> _children = [];

  @override
  void initState() {
    // TODO: implement initState
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));
    _controller.forward();
    _children.clear();
    _children.addAll(widget.taskIconBeans);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final minSize = min(size.width, size.height);
    final circleSize = minSize;
    final Offset circleOrigin = Offset((size.width - circleSize) / 2, 0);

    return WillPopScope(
        onWillPop: () {
          doExit(context, _controller);
          return Future.value(false);
        },
        child: GestureDetector(
          onTap: () {
            doExit(context, _controller);
          },
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0),
            body: Container(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 20,
                    left: size.width / 2 - 28,
                    child: AnimatedBuilder(
                        animation: _animation,
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.2),
                              shape: BoxShape.circle),
                        ),
                        builder: (ctx, child) {
                          return Transform.scale(
                            scale: (max(size.height, size.width) / 26) *
                                (_animation.value),
                            child: child,
                          );
                        }),
                  ),
                  Positioned(
                    left: circleOrigin.dx,
                    top: circleOrigin.dy,
                    child: AnimatedBuilder(
                      animation: _animation,
                      child: CircleList(
                        origin: Offset(0, -min(size.height, size.width) / 2 + 20),
                        //  origin: Offset(0, 0),
                        showInitialAnimation: true,
                        children: List.generate(_children.length, (index) {
                          return IconButton(
                            onPressed: () {
                              doExit(context, _controller);
                             /* Navigator.of(context).push(
                                new CupertinoPageRoute(
                                  builder: (ctx) {
                                    return ProviderConfig.getInstance()
                                        .getEditTaskPage(
                                      _children[index],
                                    );
                                  },
                                ),
                              );*/
                            },
                            tooltip: _children[index].taskName,
                            icon: Icon(
                              IconBean.fromBean(_children[index].iconBean),
                              size: 40,
                              color:
                              ColorBean.fromBean(_children[index].colorBean),
                            ),
                          );
                        }),
                        innerCircleColor: Theme.of(context).primaryColorLight,
                        outerCircleColor: Colors.black,
                        innerCircleRotateWithChildren: true,
                        centerWidget: GestureDetector(
                            onTap: () {
                            /*  showModalBottomSheet(
                                  context: context,
                                  builder: (ctx) {
                                    return buildSettingListView(
                                        context, globalModel);
                                  }).then((v) {
                                doExit(context, _controller);
                              });*/
                              debugPrint("点击");
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                color: Colors.transparent,
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            )),
                      ),
                      builder: (ctx, child) {
                        return Transform.translate(
                            offset: Offset(
                                0,
                                MediaQuery.of(context).size.height -
                                    (_animation.value) * circleSize),
                            child: Transform.scale(
                                scale: _animation.value, child: child));
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        ));
  }

  Future doExit(BuildContext context, AnimationController controller) async {
    widget?.onExit();
    await controller.reverse();
    Navigator.of(context).pop();
  }
}
