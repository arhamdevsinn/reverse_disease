import 'dart:ffi';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/questionsScreen/targetWeightScreen.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

class CurrentWeightScreen extends StatefulWidget {
  var gender;
  var primaryGoal;
  var bodyType;
  var targetBodyType;
  var lastTimeHappyness;
  Map? activityLevel;
  var height;
  CurrentWeightScreen({
    Key? key,
    this.gender,
    this.bodyType,
    this.primaryGoal,
    this.targetBodyType,
    this.lastTimeHappyness,
    this.activityLevel,
    this.height,
  }) : super(key: key);

  @override
  State<CurrentWeightScreen> createState() => _CurrentWeightScreenState();
}

class _CurrentWeightScreenState extends State<CurrentWeightScreen> {
  var _tabTextIndexSelected = 1;
  final _listTextTabToggle = [
    "lb",
    "kg",
  ];
  TextEditingController currentWeightController = TextEditingController();
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
            "Step 10 of 17",
            style: appBarTextStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      SizedBox(height: 30),
                      Center(
                        child: Text("What is your current weight?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                color: themeColor,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: currentWeightController,
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
                            ? currentWeightController.text = value
                            : currentWeightController.text = value + _kg;
                        currentWeightController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: currentWeightController.text.length -
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
                            ? currentWeightController.text = value
                            : currentWeightController.text = value + _lb;
                        currentWeightController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: currentWeightController.text.length -
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
                  SizedBox(height: 30),
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
                  SizedBox(height: 30),
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      ValueListenableBuilder<TextEditingValue>(
                          valueListenable: currentWeightController,
                          builder: (context, value, child) {
                            return MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: themeColor,
                              minWidth: MediaQuery.of(context).size.width,
                              height: 55,
                              onPressed: value.text.isNotEmpty
                                  ? () {
                                    print(widget.height);
                                      if (_formKey.currentState!.validate()) {
                                         Navigator.of(context).push(MaterialPageRoute(builder:(context) => TargetWeightScreen(
                                            gender: widget.gender,
                                            primaryGoal: widget.primaryGoal,
                                            bodyType: widget.bodyType,
                                            targetBodyType:
                                                widget.targetBodyType,
                                            lastTimeHappyness:
                                                widget.lastTimeHappyness,
                                            activityLevel: widget.activityLevel,
                                            height:widget.height,
                                            weight: currentWeightController.text.toString(),
                                          )));
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
      ),
    );
  }
}
