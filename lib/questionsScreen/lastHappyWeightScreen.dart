import 'dart:async';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/model/happyModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'activityLevelScreen.dart';

class LastHappyWeightScreen extends StatefulWidget {
   var gender;
  var primaryGoal;
  var bodyType;
  var targetBodyType;

   LastHappyWeightScreen({Key? key,this.gender,this.bodyType,this.primaryGoal,this.targetBodyType,}) : super(key: key);

  @override
  State<LastHappyWeightScreen> createState() => _LastHappyWeightScreenState();
}

class _LastHappyWeightScreenState extends State<LastHappyWeightScreen> {
  int _selectedIndex = 0;

  _onSelected(int index,data) {
    setState(() => _selectedIndex = index);
    Timer(const Duration(milliseconds: 50),
        () => Get.to(() =>  ActivityLevelScreen(
          gender: widget.gender,
          primaryGoal: widget.primaryGoal,
          bodyType: widget.bodyType,
          targetBodyType: widget.targetBodyType,
          lastTimeHappyness: data,
        )));
  }

  HappyModel happyModel = HappyModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 7 of 17",
            style: appBarTextStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text("When were you last happy with your weight?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: themeColor,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(
                      happyModel.happyModelList.length,
                      (index) => InkWell(
                            onTap: () => _onSelected(index, happyModel.happyModelList[index]["name"],),
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
                                      happyModel.happyModelList[index]["name"],
                                      style: TextStyle(
                                          color: _selectedIndex != null &&
                                                  _selectedIndex == index
                                              ? whitecolor
                                              : themeColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Image.asset(
                                      happyModel.happyModelList[index]["icon"],
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
