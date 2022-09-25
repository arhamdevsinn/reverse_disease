import 'dart:async';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/questionsScreen/targetZone_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/bodyType.dart';
import '../model/targetBodyType.dart';
import 'lastHappyWeightScreen.dart';

class BoyTargetBodyTypeScreen extends StatefulWidget {
  var gender;
  var primaryGoal;
  var bodyType;
   BoyTargetBodyTypeScreen({Key? key,this.gender,this.primaryGoal,this.bodyType}) : super(key: key);

  @override
  State<BoyTargetBodyTypeScreen> createState() =>
      _BoyTargetBodyTypeScreenState();
}

class _BoyTargetBodyTypeScreenState extends State<BoyTargetBodyTypeScreen> {
  int _selectedIndex = 0;

  _onSelected(int index,data) {
    setState(() => _selectedIndex = index);
    Timer(const Duration(milliseconds: 50),
        () => Get.to(() =>  LastHappyWeightScreen(
          gender: widget.gender,primaryGoal: widget.primaryGoal,
          bodyType: widget.bodyType,
          targetBodyType: data,
        )));
  }

  TargetBody targetBody = TargetBody();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 6 of 17",
            style: appBarTextStyle,
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 30),
            const Text("Choose your target body type",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    color: themeColor,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Column(
              children: List.generate(
                  targetBody.targetboyBodyType.length,
                  (index) => InkWell(
                        onTap: () {
                          print(widget.bodyType,);
                           _onSelected(index,targetBody.targetboyBodyType[index]["name"],);
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
                                  targetBody.targetboyBodyType[index]["name"],
                                  style: TextStyle(
                                      color: _selectedIndex != null &&
                                              _selectedIndex == index
                                          ? whitecolor
                                          : themeColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.asset(
                                  targetBody.targetboyBodyType[index]["icon"],
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
