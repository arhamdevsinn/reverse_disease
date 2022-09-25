import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_switch/flutter_switch.dart';

// ignore: must_be_immutable
class SwitchRowWidget extends StatefulWidget {
  SwitchRowWidget({
    Key? key,
    required this.onToggle,
    this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
    this.padding,
    this.child,
    this.showOnOff = false,
  }) : super(key: key);
  late bool onToggle;
  final String? text;
  final Widget? child;
  final Color? color;
  final double? height;
  final double? width;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool showOnOff;

  @override
  _SwitchRowWidgetState createState() => _SwitchRowWidgetState();
}

class _SwitchRowWidgetState extends State<SwitchRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.child ?? font16Textnormal(text: widget.text!),
              FlutterSwitch(
                  value: widget.onToggle,
                  height: 20,
                  width: 43,
                  toggleSize: 19,
                  padding: 3,
                  activeColor: themeColor,
                  inactiveColor: Colors.grey,
                  showOnOff: widget.showOnOff,
                  activeText: 'Yes',
                  activeTextColor: Colors.white,
                  // activeTextFontWeight: FontWeightManager.fwMedium,
                  inactiveText: 'No',
                  inactiveTextColor: Colors.white,
                  // inactiveTextFontWeight: FontWeightManager.fwMedium,
                  onToggle: (value) {
                    setState(() {
                      widget.onToggle = value;
                    });
                  }),
            ],
          ),
          // ignore: prefer_const_constructors
          Divider()
        ],
      ),
    );
  }
}
