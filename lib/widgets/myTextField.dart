import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class MyTextField extends StatelessWidget {
  String errorText;
  String hintText;
  Icon prefixIcon;
  var controller;
  bool? passVlidate;
  MyTextField(
      {required this.errorText,
      this.controller,
      this.passVlidate,
      required this.hintText,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          prefixIconColor: themeColor,
          // focusedBorder: OutlineInputBorder(
          //     borderSide: BorderSide(color: themeColor.withOpacity(0.7)),
          //     borderRadius: BorderRadius.circular(10)),
          // enabledBorder: OutlineInputBorder(
          //     borderSide: BorderSide(color: themeColor.withOpacity(0.7)),
          //     borderRadius: BorderRadius.circular(10)),
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: 15, color: blackcolor.withOpacity(0.5))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        else if(passVlidate==true){
          if(controller.text.length<6){
             errorText="Password lenght is less than six character";
             return errorText;
          }
          else if(controller.text=="123456"){
              errorText="Password is too easy";
            return errorText;
          }
        }
        return null;
      },
    );
  }
}
