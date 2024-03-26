import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ZoomContainer extends StatelessWidget {
  const ZoomContainer(
      {super.key,
      required this.closeWidget,
      required this.openWidget,
      this.duration,
      this.closedColor,
      this.openedColor,
      this.shapeBorder});
  final Widget closeWidget;
  final Widget openWidget;
  final Duration? duration;
  final Color? closedColor;
  final Color? openedColor;
  final ShapeBorder? shapeBorder;
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: closedColor ?? Theme.of(context).cardColor,
      openColor: closedColor ?? Theme.of(context).cardColor,
      closedElevation: 0,
      openElevation: 0,
      closedShape: shapeBorder ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      transitionDuration: duration ?? Duration(milliseconds: 200),
      closedBuilder: (context, action) =>
          InkWell(onTap: action, child: closeWidget),
      openBuilder: (context, action) => openWidget,
    );
  }
}
