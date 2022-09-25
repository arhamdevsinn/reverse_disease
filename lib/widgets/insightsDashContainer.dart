import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class InsightsDashBoardContainer extends StatelessWidget {
  Color color;
  Color color2;
  Widget widget;
  double width;
  double height;
  InsightsDashBoardContainer(
      {required this.color,
      required this.color2,
      required this.widget,
      required this.width,
      required this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[color, color2]),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15), child: widget),
    );
  }
}
