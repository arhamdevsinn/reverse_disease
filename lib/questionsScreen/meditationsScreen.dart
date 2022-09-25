import 'dart:async';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/model/happyModel.dart';
import 'package:fitness_app_flutter/model/meditationsModel.dart';
import 'package:fitness_app_flutter/questionsScreen/targetZone_screen.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/activityLevel.dart';
import '../model/bodyType.dart';
import '../model/targetBodyType.dart';
import 'follow_dietScreen.dart';
import 'howTallScreen.dart';

class MeditationScreen extends StatefulWidget {
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
   MeditationScreen({Key? key,
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
  }) : super(key: key);

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  MeditationsModel meditationsModel = MeditationsModel();
  @override
  var data;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 13 of 17",
            style: appBarTextStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text("Are you taking any meditations?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: themeColor,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(
                      meditationsModel.meditationsList.length,
                      (index) => InkWell(
                            onTap: () => {
                                          
                              setState(() {
                                data= meditationsModel.meditationsList[index]["title"];
                                meditationsModel.meditationsList[index]
                                        ["onSelect"] =
                                    !meditationsModel.meditationsList[index]
                                        ["onSelect"];
                              })
                            },
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: whitecolor,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        meditationsModel.meditationsList[index]
                                            ["title"],
                                        style: const TextStyle(
                                            color: themeColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Image.asset(
                                        meditationsModel.meditationsList[index]
                                            ["icon"],
                                        height: 25,
                                        color: meditationsModel
                                                    .meditationsList[index]
                                                ["onSelect"]
                                            ? themeColor
                                            : Colors.grey.withOpacity(0.2),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
                const SizedBox(height: 20),
                CustomButton(
                    color: themeColor,
                    buttonText: "Continue",
                    onTap: () {
                      Get.to(() =>  FollowDietsScreen(
                   gender: widget.gender,
                                            primaryGoal: widget.primaryGoal,
                                            bodyType: widget.bodyType,
                                            targetBodyType:
                                                widget.targetBodyType,
                                            lastTimeHappyness:
                                                widget.lastTimeHappyness,
                                            activityLevel: widget.activityLevel,
                                            height:widget.height,
                                            weight: widget.weight,
                                            targetWeight: widget.targetWeight,
                                            age: widget.age,
                                            meditation:data ,

                      ));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
