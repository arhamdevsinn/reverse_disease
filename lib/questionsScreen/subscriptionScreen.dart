import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/questionsScreen/enter_emailscreen.dart';
import 'package:fitness_app_flutter/sign_up.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatefulWidget {
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
  var eventDate;
  SubscriptionScreen(
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
      this.firstMeal,
      this.lastMeal,
      this.occasion,
      this.eventDate})
      : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          const SizedBox(height: 20),
          font28Textbold(text: "Subscription"),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
                buttonText: "Continue",
                onTap: () {
                  Get.to(() => SignUp(
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
                      eventDate: widget.eventDate));
                },
                color: themeColor),
          )
        ]),
      ),
    );
  }
}
