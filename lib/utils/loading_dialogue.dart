import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:flutter/material.dart';

Future loading({fastingTime, startTime, @required context}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return const  Center(
          child:  CircularProgressIndicator(color: themeColor,));
          
        
      });
}
