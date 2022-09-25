import 'dart:async';
import 'dart:developer';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/questionsScreen/targetZone_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/firestore_model/steps_model.dart';
import '../model/primaryGoal.dart';
import '../repository/steps_storage.dart';

class PrimaryGoalScreen extends StatefulWidget {
  var gender;
   PrimaryGoalScreen({Key? key,this.gender}) : super(key: key);

  @override
  State<PrimaryGoalScreen> createState() => _PrimaryGoalScreenState();
}

class _PrimaryGoalScreenState extends State<PrimaryGoalScreen> {
  int _selectedIndex = 0;

  _onSelected(int index,data) {
    setState(() => _selectedIndex = index);
    Timer(const Duration(milliseconds: 50),
        () => Get.to(() =>  TargetZoneScreen(gender:widget.gender,primaryGoal:data)));
  }

  PrimaryGoalModel primaryGoalModel = PrimaryGoalModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 3 of 17",
            style: appBarTextStyle,
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 30),
            const Text("What is your primary goal?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    color: themeColor,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Column(
              children: List.generate(
                  primaryGoalModel.primaryGoalModelList.length,
                  (index) => InkWell(
                        onTap: () {
                         
                          log("${widget.gender}");
                          _onSelected(index, primaryGoalModel.primaryGoalModelList[index]
                                      ["name"],);
                        },
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  primaryGoalModel.primaryGoalModelList[index]
                                      ["name"],
                                  style: TextStyle(
                                      color: _selectedIndex != null &&
                                              _selectedIndex == index
                                          ? whitecolor
                                          : themeColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.asset(
                                  primaryGoalModel.primaryGoalModelList[index]
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
    );
  }
}
