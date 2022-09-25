import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/questionsScreen/planReadyScreen.dart';
import 'package:fitness_app_flutter/questionsScreen/specialOccasionScreen.dart';
import 'package:fitness_app_flutter/questionsScreen/targetWeightScreen.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

import 'meditationsScreen.dart';

class EventScreen extends StatefulWidget {
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
  var occasion;
  EventScreen({
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
    this.dietFollow,
    this.firstMeal,
    this.lastMeal,
    this.occasion,
  }) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  DateTime dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
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
                      child: Text("When is your event?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              color: themeColor,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 20),
                    Text(
                        "Once we know this, we'll be able to put together a personalized plan to help you get in shape.\n Your data will not be shared with any third parties.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            color: themeColor,
                            fontWeight: FontWeight.w400)),
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
                        mode: CupertinoDatePickerMode.date,
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
                    // const Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Text(
                    //     "Skip this question",
                    //     style: TextStyle(decoration: TextDecoration.underline),
                    //   ),
                    // ),
                    CustomButton(
                        color: themeColor,
                        buttonText: "Continue",
                        onTap: () {
                          Get.to(() =>  PlanReadyScreen(
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
                                occasion: widget.occasion,
                                eventDate: dateTime,
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
