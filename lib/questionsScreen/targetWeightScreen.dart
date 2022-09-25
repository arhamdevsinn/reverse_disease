import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

import 'howOldScreen.dart';

class TargetWeightScreen extends StatefulWidget {
   var gender;
  var primaryGoal;
  var bodyType;
  var targetBodyType;
  var lastTimeHappyness;
  Map? activityLevel;
  var height;
  var weight;
   TargetWeightScreen({Key? key,
    this.gender,
    this.bodyType,
    this.primaryGoal,
    this.targetBodyType,
    this.lastTimeHappyness,
    this.activityLevel,
    this.height,
    this.weight
  }) : super(key: key);

  @override
  State<TargetWeightScreen> createState() => _TargetWeightScreenState();
}

class _TargetWeightScreenState extends State<TargetWeightScreen> {
  var _tabTextIndexSelected = 1;
  final _listTextTabToggle = [
    "lb",
    "kg",
  ];
  TextEditingController targetWeightController = TextEditingController();
  // final TextEditingController _textController = TextEditingController();
  final String _lb = " lb";
  final String _kg = " kg";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 11 of 17",
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
                      child: Text("What is your target weight?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              color: themeColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                TextFormField(
                  controller: targetWeightController,
                  validator: (value) {
                    if (_tabTextIndexSelected == 1) {
                      if (int.parse(value!) <= 30) {
                        return "Please enter a number between 30 and 50";
                      } else if (int.parse(value) >= 50) {
                        return "Please enter a number between 30 and 50";
                      }
                    }
                    if (_tabTextIndexSelected == 1) {
                      value!.endsWith(_kg)
                          ? targetWeightController.text = value
                          : targetWeightController.text = value + _kg;
                      targetWeightController.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset: targetWeightController.text.length -
                                  _kg.length));
                    } else if (_tabTextIndexSelected == 0) {
                      if (int.parse(value!) <= 66) {
                        return "Please enter a number between 66 and 331";
                      } else if (int.parse(value) >= 331) {
                        return "Please enter a number between 66 and 331";
                      }
                    }
                    if (_tabTextIndexSelected == 0) {
                      value!.endsWith(_lb)
                          ? targetWeightController.text = value
                          : targetWeightController.text = value + _lb;
                      targetWeightController.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset: targetWeightController.text.length -
                                  _lb.length));
                    }
                    return null;
                  },
                  decoration: const InputDecoration(),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                FlutterToggleTab(
                  // width in percent
                  width: 30,
                  borderRadius: 30,
                  height: 30,
                  selectedIndex: _tabTextIndexSelected,
                  selectedBackgroundColors: [themeColor],
                  selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  unSelectedTextStyle: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  labels: _listTextTabToggle,
                  selectedLabelIndex: (index) {
                    setState(() {
                      _tabTextIndexSelected = index;
                    });
                  },
                  isScroll: false,
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    ValueListenableBuilder<TextEditingValue>(
                        valueListenable: targetWeightController,
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
                                      print(widget.weight);
                                      Get.to(() =>  HowOldScreen(
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
                                            targetWeight: targetWeightController.text.toString(),
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
