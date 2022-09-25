import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  VoidCallback onTap;
  Color color;

  CustomButton(
      {required this.buttonText, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: color,
      minWidth: MediaQuery.of(context).size.width,
      height: 55,
      onPressed: onTap,
      child: Text(
        buttonText,
        style: const TextStyle(
            fontSize: 16, color: whitecolor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
