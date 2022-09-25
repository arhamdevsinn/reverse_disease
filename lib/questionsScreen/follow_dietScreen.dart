import 'dart:async';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/model/happyModel.dart';
import 'package:fitness_app_flutter/questionsScreen/targetZone_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/activityLevel.dart';
import '../model/bodyType.dart';
import '../model/dietsModel.dart';
import '../model/targetBodyType.dart';
import 'first_mealScreen.dart';
import 'howTallScreen.dart';

class FollowDietsScreen extends StatefulWidget {
  var gender;
  var primaryGoal;
  var bodyType;
  var targetBodyType;
  var lastTimeHappyness;
  Map? activityLevel;
  var height;
  var weight;
  var targetWeight;
  var age;
  var meditation;
  FollowDietsScreen({
    Key? key,
    this.gender,
    this.bodyType,
    this.primaryGoal,
    this.targetBodyType,
    this.lastTimeHappyness,
    this.activityLevel,
    this.height,
    this.weight,
    this.targetWeight,
    this.age,
    this.meditation,
  }) : super(key: key);

  @override
  State<FollowDietsScreen> createState() => _FollowDietsScreenState();
}

class _FollowDietsScreenState extends State<FollowDietsScreen> {
  int _selectedIndex = 0;

  _onSelected(int index, data) {
    setState(() => _selectedIndex = index);
    Timer(
        const Duration(milliseconds: 50),
        () => Get.to(() => FirstMealScreen(
              gender: widget.gender,
              primaryGoal: widget.primaryGoal,
              bodyType: widget.bodyType,
              targetBodyType: widget.targetBodyType,
              lastTimeHappyness: widget.lastTimeHappyness,
              activityLevel: widget.activityLevel,
              height: widget.height,
              weight: widget.weight,
              targetWeight: widget.targetWeight,
              age: widget.age,
              meditation: widget.meditation,
              dietFollow: data,
            )));
  }

  DietsModel dietsModel = DietsModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 14 of 17",
            style: appBarTextStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text("Do you follow any of these diets?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: themeColor,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(
                      dietsModel.dietsList.length,
                      (index) => InkWell(
                            onTap: () {
                              Map data = {
                                "title": dietsModel.dietsList[index]["title"]??"",
                                "subtitle": dietsModel.dietsList[index]
                                    ["subtitle"]??"",
                              };
                              _onSelected(index, data);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: _selectedIndex != null &&
                                          _selectedIndex == index
                                      ? themeColor
                                      : whitecolor,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 5),
                                          Text(
                                            dietsModel.dietsList[index]
                                                ["title"],
                                            style: TextStyle(
                                                color: _selectedIndex != null &&
                                                        _selectedIndex == index
                                                    ? whitecolor
                                                    : themeColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                              dietsModel.dietsList[index]
                                                  ["subtitle"],
                                              style: TextStyle(
                                                  color:
                                                      _selectedIndex != null &&
                                                              _selectedIndex ==
                                                                  index
                                                          ? whitecolor
                                                          : themeColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500))
                                        ],
                                      ),
                                    ),
                                    Image.asset(
                                      dietsModel.dietsList[index]["icon"],
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
        ),
      ),
    );
  }
}
