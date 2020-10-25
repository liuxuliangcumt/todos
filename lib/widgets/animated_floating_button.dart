import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todos/util/full_screen_dialog.dart';

class AnimatedFloatingButton extends StatefulWidget {
  final Color bgColor;

  const AnimatedFloatingButton({this.bgColor});

  @override
  _AnimatedFloatingButtonState createState() => _AnimatedFloatingButtonState();
}

class _AnimatedFloatingButtonState extends State<AnimatedFloatingButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = new Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (ct, child) {
        return Transform.translate(
          offset: Offset(0, (_animation.value) * 56),
          child: Transform.scale(
            scale: 1 - _animation.value * 2,
            child: child,
          ),
        );
      },
      child: Transform.rotate(
        angle: -pi / 2,
        child: FloatingActionButton(
          onPressed: () async {
            FullScreenDialog.getInstance().showDialog(
                context,
                BottomShowWidget(
                  onExit: () {
                    _controller.reverse();
                  },
                  taskIconBeans: await IconListUtil.getInstance()
                      .getIconWithCache(context),
                ));
            _controller.forward();
          },
          child: Icon(
            Icons.alarm,
            size: 25,
            color: Colors.white,
          ),
          backgroundColor: Colors.amber,
          shape: StadiumBorder(side: BorderSide(color: Colors.black, width: 2)),
        ),
      ),
    );
  }
}
