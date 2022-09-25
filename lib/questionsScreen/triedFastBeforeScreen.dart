import 'dart:async';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/model/happyModel.dart';
import 'package:fitness_app_flutter/questionsScreen/targetZone_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/activityLevel.dart';
import '../model/bodyType.dart';
import '../model/targetBodyType.dart';
import '../model/triedFast.dart';
import 'howTallScreen.dart';

class TriedFastBeforeScreen extends StatefulWidget {
  const TriedFastBeforeScreen({Key? key}) : super(key: key);

  @override
  State<TriedFastBeforeScreen> createState() => _TriedFastBeforeScreenState();
}

class _TriedFastBeforeScreenState extends State<TriedFastBeforeScreen> {
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
    // Timer(const Duration(milliseconds: 50),
    //     () => Get.to(() => const HowTallScreen()));
  }

  TriedFastBefore triedFastBefore = TriedFastBefore();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text("Have you tried fasting before?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: themeColor,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(
                      triedFastBefore.triedFastBeforeScreenList.length,
                      (index) => InkWell(
                            onTap: () => _onSelected(index),
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
                                    Text(
                                      triedFastBefore
                                              .triedFastBeforeScreenList[index]
                                          ["title"],
                                      style: TextStyle(
                                          color: _selectedIndex != null &&
                                                  _selectedIndex == index
                                              ? whitecolor
                                              : themeColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
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
