import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/questionsScreen/targetWeightScreen.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

import 'meditationsScreen.dart';

class HowOldScreen extends StatefulWidget {
  var gender;
  var primaryGoal;
  var bodyType;
  var targetBodyType;
  var lastTimeHappyness;
  Map? activityLevel;
  var height;
  var weight;
  var targetWeight;
   HowOldScreen({Key? key,
   this.gender,
    this.bodyType,
    this.primaryGoal,
    this.targetBodyType,
    this.lastTimeHappyness,
    this.activityLevel,
    this.height,
    this.weight,
    this.targetWeight
  }) : super(key: key);

  @override
  State<HowOldScreen> createState() => _HowOldScreenState();
}

class _HowOldScreenState extends State<HowOldScreen> {
  TextEditingController ageOldController = TextEditingController();
  // final TextEditingController _textController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 12 of 17",
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
                      child: Text("How old are you?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              color: themeColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                TextFormField(
                  controller: ageOldController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your age";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    ValueListenableBuilder<TextEditingValue>(
                        valueListenable: ageOldController,
                        builder: (context, value, child) {
                          return MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: themeColor,
                            minWidth: MediaQuery.of(context).size.width,
                            height: 55,
                            onPressed: value.text.isNotEmpty
                                ? () {
                                    if (_formKey.currentState!.validate()) {
                                      Get.to(() =>  MeditationScreen(
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
                                            age: value.text,
                                      ));
                                    }
                                  }
                                : null,
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: value.text.isNotEmpty
                                      ? whitecolor
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
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
