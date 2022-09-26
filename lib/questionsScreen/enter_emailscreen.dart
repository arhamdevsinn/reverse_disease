import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/customBotttomNav.dart';
import 'package:fitness_app_flutter/model/firestore_model/steps_model.dart';
import 'package:fitness_app_flutter/repository/steps_storage.dart';
import 'package:fitness_app_flutter/sign_up.dart';
import 'package:fitness_app_flutter/utils/snakbar.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:fitness_app_flutter/widgets/myTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../fastingScreens/fastingProtocolScreen.dart';

class EnterEmailScreen extends StatefulWidget {
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
  EnterEmailScreen(
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
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

final _formKey = GlobalKey<FormState>();
bool checkValue = false;
bool checkRoute = false;

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  TextEditingController emailController = TextEditingController();
  StepsStorage stepsStorage=StepsStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        backgroundColor: whitecolor,
        elevation: 0.0,
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "Start your positive change NOW",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: themeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: emailController,
                    errorText: "Please enter your email",
                    hintText: "Email",
                    prefixIcon: const Icon(
                      Icons.email,
                      color: themeColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    buttonText: "Continue",
                    color: themeColor,
                    onTap: () async{
                      var connectivity=await Connectivity().checkConnectivity();
                      if (_formKey.currentState!.validate()) {
                        if(connectivity == ConnectivityResult.mobile||connectivity==ConnectivityResult.wifi){
                        var data = {
                          "gender": widget.gender,
                          "primary-goal": widget.primaryGoal,
                          "body-type": widget.bodyType,
                          "target-body-type": widget.targetBodyType,
                          "last-time-happyness": widget.lastTimeHappyness,
                          "activity-Level":{
                            "title":widget.activityLevel!["title"],
                            "subtitle":widget.activityLevel!["subtitle"]
                          },
                          "height": widget.height,
                          "weight": widget.weight,
                          "target-wight": widget.targetWeight,
                          "age": widget.age,
                          "meditation": widget.meditation,
                          // "diet-follow":widget.dietFollow,
                          "diet-follow": {
                            "title":widget.dietFollow!["title"],
                            "subtitle":widget.dietFollow!["subtitle"],
                          },
                          "first-meal": widget.firstMeal,
                          "last-meal": widget.lastMeal,
                          "occasion": widget.occasion,
                          "event-date": widget.eventDate,
                          "email": emailController.text,
                        };
                        // StepsModel model = StepsModel.fromJson(data);
                        // log("${model.toJson()}");
                        stepsStorage.enterData(data).then((value) {
                          print("this is $value");
                         

                        showSnackbar(context, "Data is added sucessfully");
                        Get.to(() => SignUp(
                              
                            ));
                        
                        
                        });
                       
                        }
                        else{
                          showSnackbar(context, "Check your internet connection");
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
