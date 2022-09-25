import 'dart:async';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/screen_util.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/questionsScreen/targetZone_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/bodyType.dart';
import 'boyTargetBodyType.dart';

class BoyBodyTypeScreen extends StatefulWidget {
  var gender;
  var primaryGoal;
   BoyBodyTypeScreen({Key? key,this.gender,this.primaryGoal}) : super(key: key);

  @override
  State<BoyBodyTypeScreen> createState() => _BoyBodyTypeScreenState();
}

class _BoyBodyTypeScreenState extends State<BoyBodyTypeScreen> {
  int _selectedIndex = 0;

  _onSelected(int index,data) {
    setState(() => _selectedIndex = index);
    Timer(const Duration(milliseconds: 50),
        () => Get.to(() =>  BoyTargetBodyTypeScreen(gender: widget.gender,primaryGoal: widget.primaryGoal,bodyType: data,)));
  }

  BodyTypeModel bodyTypeModel = BodyTypeModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 5 of 17",
            style: appBarTextStyle,
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 30),
            const Text("Choose your body type",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    color: themeColor,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Column(
              children: List.generate(
                  bodyTypeModel.boyBodyType.length,
                  (index) => InkWell(
                        onTap: () => _onSelected(index,   bodyTypeModel.boyBodyType[index]["name"],),
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
                                  bodyTypeModel.boyBodyType[index]["name"],
                                  style: TextStyle(
                                      color: _selectedIndex != null &&
                                              _selectedIndex == index
                                          ? whitecolor
                                          : themeColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.asset(
                                  bodyTypeModel.boyBodyType[index]["icon"],
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
