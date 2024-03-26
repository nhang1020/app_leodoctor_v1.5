import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';

class ScaffoldDraggable extends StatefulWidget {
  const ScaffoldDraggable(
      {super.key, required this.child, required this.button});
  final Widget button;
  final Widget child;
  @override
  State<ScaffoldDraggable> createState() => _ScaffoldDraggableState();
}

class _ScaffoldDraggableState extends State<ScaffoldDraggable> {
  Offset position = Offset(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    double height = screen(context).height;
    double y = position.dy;
    position = Offset(screen(context).width, height);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            widget.child,
            Positioned(
                right: 20,
                bottom: y > height - height / 3
                    ? 30
                    : (y < height - height / 3 && y > height / 3
                        ? height / 2.5
                        : null),
                child: Draggable(
                    feedback: Container(
                      child: widget.button,
                    ),
                    child: Container(
                      child: widget.button,
                    ),
                    childWhenDragging: Container(),
                    onDragEnd: (details) {
                      setState(() {
                        position = details.offset;
                      });
                    }))
          ],
        ));
  }
}
