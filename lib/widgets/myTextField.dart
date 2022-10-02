import 'package:fitness_app_flutter/constants/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class MyTextField extends StatefulWidget {
  String errorText;
  String hintText;
  Icon prefixIcon;
  var controller;
  bool? passVlidate;
  bool? obscureTextValue;
  MyTextField(
      {required this.errorText,
      this.controller,
      this.passVlidate,
      this.obscureTextValue,
      required this.hintText,
      required this.prefixIcon});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureTextValue ?? false,
      decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.passVlidate == true
              ? GestureDetector(
                  onTap: () {
                    if (widget.obscureTextValue == true) {
                      setState(() {
                        widget.obscureTextValue = false;
                      });
                    } else {
                      widget.obscureTextValue = true;
                      setState(() {});
                    }
                  },
                  child: widget.obscureTextValue != true
                      ? const Icon(
                          Icons.visibility,
                          color: themeColor,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: themeColor,
                        ),
                )
              : null,
          prefixIconColor: themeColor,
          hintText: widget.hintText,
          hintStyle:
              TextStyle(fontSize: 15, color: blackcolor.withOpacity(0.5))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.errorText;
        } else if (widget.passVlidate == true) {
          if (widget.controller.text.length < 6) {
            widget.errorText = "Password lenght is less than six character";
            return widget.errorText;
          } else if (widget.controller.text == "123456") {
            widget.errorText = "Password is too easy";
            return widget.errorText;
          }
        }
        return null;
      },
    );
  }
}
