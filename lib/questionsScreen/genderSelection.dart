import 'dart:async';
import 'dart:convert';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/model/gender.dart';
import 'package:fitness_app_flutter/questionsScreen/primaryGoalScreen.dart';
import 'package:fitness_app_flutter/repository/steps_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/firestore_model/steps_model.dart';
import '../role_selection_screen.dart';

class GenderSelection extends StatefulWidget {
  const GenderSelection({Key? key}) : super(key: key);

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  int _selectedIndex = 0;

  _onSelected(int index,data) {
    setState(() => _selectedIndex = index);
    Timer(const Duration(milliseconds: 50),
        () => Get.to(() =>  PrimaryGoalScreen(gender:data)));
  }

  Gender gender = Gender();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 2 of 17",
            style: appBarTextStyle,
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 30),
            const Text("What is your gender?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 27,
                    color: themeColor,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Column(
              children: List.generate(
                  3,
                  (index) => InkWell(
                        onTap: () {
                     
                          _onSelected(index, gender.genderList[index]["name"],);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: _selectedIndex != null &&
                                      _selectedIndex == index
                                  ? themeColor
                                  : whitecolor,
                              borderRadius: BorderRadius.circular(10)),
                          height: 70,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  gender.genderList[index]["name"],
                                  style: TextStyle(
                                      color: _selectedIndex != null &&
                                              _selectedIndex == index
                                          ? whitecolor
                                          : themeColor,
                                      fontSize: 16,
                                      fontFamily: "Campton",
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.asset(
                                  gender.genderList[index]["icon"],
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
