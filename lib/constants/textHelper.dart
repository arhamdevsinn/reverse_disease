import 'package:flutter/material.dart';

Text font12Textnormal({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: TextStyle(
      color: color ?? Colors.black,
      fontSize: 12,
    ),
  );
}

Text font14Textnormal({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: TextStyle(
      color: color ?? Colors.black,
      fontSize: 14,
    ),
  );
}

Text font14Textbold({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: TextStyle(
      color: color ?? Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text font16Textnormal({
  required dynamic text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
}) {
  return Text(
    text!,
    textAlign: textAlign ?? TextAlign.start,
    style: TextStyle(
      color: color ?? Colors.black,
      fontSize: 16,
    ),
  );
}

Text font16Textbold({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: TextStyle(
      color: color ?? Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text font18Textmedium({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: TextStyle(
      color: color ?? Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  );
}

Text font18Textbold({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: TextStyle(
      color: color ?? Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text font20Textbold({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text font22Textbold({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text font28Textbold({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
  );
}
