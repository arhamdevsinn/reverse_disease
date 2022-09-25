import 'dart:async';
import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/model/occasionModel.dart';
import 'package:fitness_app_flutter/questionsScreen/targetZone_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/bodyType.dart';
import 'boyTargetBodyType.dart';
import 'eventScreen.dart';

class SpecialOccasionScreen extends StatefulWidget {
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
  Map? dietFollow;
 var firstMeal;
 var lastMeal;
   SpecialOccasionScreen({Key? key,
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
    this.dietFollow,
    this.firstMeal,
    this.lastMeal
  }) : super(key: key);

  @override
  State<SpecialOccasionScreen> createState() => _SpecialOccasionScreenState();
}

class _SpecialOccasionScreenState extends State<SpecialOccasionScreen> {
  int _selectedIndex = 0;

  _onSelected(int index,data) {
    setState(() => _selectedIndex = index);
    Timer(const Duration(milliseconds: 50),
        () => Get.to(() =>  EventScreen(
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
                                dietFollow: widget.dietFollow,
                                firstMeal: widget.firstMeal,
                                lastMeal: widget.lastMeal,
                                occasion: data,
        )));
  }

  OccasionModel occasionModel = OccasionModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 17 of 17",
            style: appBarTextStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                  "Is there a special occasion you want to lose your weight?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      color: themeColor,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text(
                  "You are more likely to reach your goal if you have something important to aim for",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      color: themeColor,
                      fontWeight: FontWeight.w400)),
              Column(
                children: List.generate(
                    occasionModel.occasionsList.length,
                    (index) => InkWell(
                          onTap: () => _onSelected(index,occasionModel.occasionsList[index]["name"],),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    occasionModel.occasionsList[index]["name"],
                                    style: TextStyle(
                                        color: _selectedIndex != null &&
                                                _selectedIndex == index
                                            ? whitecolor
                                            : themeColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Image.asset(
                                    occasionModel.occasionsList[index]["icon"],
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
    );
  }
}
