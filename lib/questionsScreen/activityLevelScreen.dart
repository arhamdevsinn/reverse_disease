import 'dart:async';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/activityLevel.dart';
import 'howTallScreen.dart';

class ActivityLevelScreen extends StatefulWidget {
   var gender;
  var primaryGoal;
  var bodyType;
  var targetBodyType;
  var lastTimeHappyness;
   ActivityLevelScreen({Key? key,this.gender,this.bodyType,this.primaryGoal,this.targetBodyType,this.lastTimeHappyness,}) : super(key: key);

  @override
  State<ActivityLevelScreen> createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends State<ActivityLevelScreen> {
  int _selectedIndex = 0;

  _onSelected(int index,data) {
    setState(() => _selectedIndex = index);
    Timer(const Duration(milliseconds: 50),
        () => Get.to(() =>  HowTallScreen(
          gender: widget.gender,
          primaryGoal: widget.primaryGoal,
          bodyType: widget.bodyType,
          targetBodyType: widget.targetBodyType,
          lastTimeHappyness: widget.lastTimeHappyness,
          activityLevel: data,
        )));
  }

  ActivityLevelModel activityLevelModel = ActivityLevelModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 8 of 17",
            style: appBarTextStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text("What is your activity level?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: themeColor,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(
                      activityLevelModel.activityLevelModelList.length,
                      (index) => InkWell(
                            onTap: () { 
                                Map data={
                                  "title": activityLevelModel
                                                    .activityLevelModelList[
                                                index]["title"],
                                   "subtitle":   activityLevelModel
                                                    .activityLevelModelList[
                                                index]["subtitle"],           
                                };
                              _onSelected(index,data);
                              },
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: _selectedIndex != null &&
                                          _selectedIndex == index
                                      ? themeColor
                                      : whitecolor,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 85,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            activityLevelModel
                                                    .activityLevelModelList[
                                                index]["title"],
                                            style: TextStyle(
                                                color: _selectedIndex != null &&
                                                        _selectedIndex == index
                                                    ? whitecolor
                                                    : themeColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            activityLevelModel
                                                    .activityLevelModelList[
                                                index]["subtitle"],
                                            style: TextStyle(
                                                color: _selectedIndex != null &&
                                                        _selectedIndex == index
                                                    ? whitecolor
                                                    : themeColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                    Image.asset(
                                      activityLevelModel
                                              .activityLevelModelList[index]
                                          ["icon"],
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
