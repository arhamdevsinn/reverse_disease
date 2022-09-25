import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/questionsScreen/specialOccasionScreen.dart';
import 'package:fitness_app_flutter/questionsScreen/targetWeightScreen.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

import 'meditationsScreen.dart';

class LastMealScreen extends StatefulWidget {
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
  LastMealScreen(
      {Key? key,
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
      this.firstMeal})
      : super(key: key);

  @override
  State<LastMealScreen> createState() => _LastMealScreenState();
}

class _LastMealScreenState extends State<LastMealScreen> {
  DateTime dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 16 of 17",
            style: appBarTextStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    SizedBox(height: 30),
                    Center(
                      child: Text("When do you usually have your last meal?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              color: themeColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SizedBox(
                    height: 200,
                    child: CupertinoTheme(
                      data: const CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        initialDateTime: dateTime,
                        onDateTimeChanged: (newDateTime) {
                          setState(() {
                            dateTime = newDateTime;
                          });
                        },
                      ),
                    )),
                Column(
                  children: [
                    CustomButton(
                        color: themeColor,
                        buttonText: "Continue",
                        onTap: () {
                          Get.to(() => SpecialOccasionScreen(
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
                                lastMeal: dateTime,
                              ));
                        }),
                    const SizedBox(height: 30),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
