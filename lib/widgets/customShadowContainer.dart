import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/colors.dart';

class CustomShadowContainer extends StatelessWidget {
  Widget widget;
  CustomShadowContainer({super.key, required this.widget});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: whitecolor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [kDefaultShadow]),
      child: widget,
    );
  }
}
