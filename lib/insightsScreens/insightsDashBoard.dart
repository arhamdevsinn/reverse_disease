import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/insightsScreens/insightScreen1.dart';
import 'package:fitness_app_flutter/model/insight.dart';
import 'package:fitness_app_flutter/widgets/insightsDashContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import '../constants/textHelper.dart';
import 'AllInsightsScreen.dart';
import "package:http/http.dart" as http;

class InsightsDashBoard extends StatefulWidget {
  const InsightsDashBoard({Key? key}) : super(key: key);

  @override
  State<InsightsDashBoard> createState() => _InsightsDashBoardState();
}

class _InsightsDashBoardState extends State<InsightsDashBoard> {
  InsightModel? model;
  List list = [];
  fun() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("jason/data.json");
    var jsonResult = jsonDecode(data);
    model = InsightModel.fromJson(jsonResult);
    // print(model!.whatCanIEat![0].option![0].toJson());
    setState(() {});
    //  list.add(model!);
  }

  @override
  void initState() {
    super.initState();
    fun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whitecolor,
        appBar: AppBar(
          backgroundColor: whitecolor,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: model == null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      font28Textbold(text: 'Insights'),
                      const SizedBox(height: 10),
                      font22Textbold(text: 'Trending'),
                      const SizedBox(height: 10),
                      InsightsDashBoardContainer(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        color: insightsColor[0],
                        color2: insightsColor[1],
                        widget: InkWell(
                          onTap: () {
                            // log("${model!.trending!.options!}");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        //           // fastingProtocolScreens[index]),
                                        CustomStoryView(
                                          data: model!.trending!
                                              .toJson()['options'],
                                        )));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              font18Textbold(
                                  text: model!.trending!.title.toString()),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Image.asset("images/breakfast.png",
                                    height: 80),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Get.to(() => AllInsightsScreen(
                                title: 'ABC of Fasting',
                                model: model!.abcOfFasting!,
                              ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            font18Textbold(text: "ABC of Fasting"),
                            const Text("see all"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              // log("${ model!.abcOfFasting![0].toJson()["option"]}");
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.abcOfFasting![0].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              color2: insightsColor[2],
                              height: 150,
                              width: 150,
                              color: allInsightsColor[3],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.abcOfFasting![0].title
                                          .toString())),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.abcOfFasting![1].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              color2: allInsightsColor[1],
                              height: 150,
                              width: 150,
                              color: allInsightsColor[4],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.abcOfFasting![1].title
                                          .toString())),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          font18Textbold(text: "What Can I Eat?"),
                          InkWell(
                              onTap: () {
                                Get.to(() => AllInsightsScreen(
                                      title: 'What Can I Eat?',
                                      model: model!.whatCanIEat!,
                                    ));
                              },
                              child: const Text("see all")),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.whatCanIEat![0].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              color2: allInsightsColor[7],
                              height: 150,
                              width: 150,
                              color: allInsightsColor[5],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.whatCanIEat![0].title
                                          .toString())),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.whatCanIEat![1].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              color2: insightsColor[2],
                              height: 150,
                              width: 150,
                              color: allInsightsColor[6],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.whatCanIEat![1].title
                                          .toString())),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          font18Textbold(text: "Body and Mind"),
                          InkWell(
                              onTap: () {
                                Get.to(() => AllInsightsScreen(
                                      title: 'Body and Mind',
                                      model: model!.bodyAndMind!,
                                    ));
                              },
                              child: const Text("see all")),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.bodyAndMind![0].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              color2: allInsightsColor[5],
                              height: 150,
                              width: 150,
                              color: fastingProtocolColors[2],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.bodyAndMind![0].title
                                          .toString())),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.bodyAndMind![1].toJson()["option"]
                                        )));

                            },
                            child: InsightsDashBoardContainer(
                              color2: insightsColor[0],
                              height: 150,
                              width: 150,
                              color: allInsightsColor[5],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.bodyAndMind![1].title
                                          .toString())),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          font18Textbold(text: "Easting Healthy"),
                          InkWell(
                              onTap: () {
                                Get.to(() => AllInsightsScreen(
                                      title: 'Eating Healthy',
                                      model: model!.eatingHealthy!,
                                    ));
                              },
                              child: const Text("see all")),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.eatingHealthy![0].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              color2: allInsightsColor[4],
                              height: 150,
                              width: 150,
                              color: allInsightsColor[2],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.eatingHealthy![0].title
                                          .toString())),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.eatingHealthy![1].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              color2: insightsColor[1],
                              height: 150,
                              width: 150,
                              color: fastingProtocolColors[1],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.eatingHealthy![1].title
                                          .toString())),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          font18Textbold(text: "Fasting Challenge"),
                          InkWell(
                              onTap: () {
                                Get.to(() => AllInsightsScreen(
                                      title: 'Fasting Challenge',
                                      model: model!.fastingChallenge!,
                                    ));
                              },
                              child: const Text("see all")),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.fastingChallenge![0].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              color2: allInsightsColor[7],
                              height: 150,
                              width: 150,
                              color: allInsightsColor[5],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.fastingChallenge![0].title
                                          .toString())),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.fastingChallenge![1].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              color2: allInsightsColor[0],
                              height: 150,
                              width: 150,
                              color: allInsightsColor[6],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.fastingChallenge![1].title
                                          .toString())),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          font18Textbold(text: "Fasting Explained"),
                          InkWell(
                              onTap: () {
                                Get.to(() => AllInsightsScreen(
                                      title: 'Fasting Explained',
                                      model: model!.fastingExplained!,
                                    ));
                              },
                              child: const Text("see all")),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                             onTap: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.fastingExplained![0].toJson()["option"]
                                        )));
                             },
                            child: InsightsDashBoardContainer(
                              color2: insightsColor[1],
                              height: 150,
                              width: 150,
                              color: fastingProtocolColors[5],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.fastingExplained![0].title
                                          .toString())),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.fastingExplained![1].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              height: 150,
                              color2: insightsColor[2],
                              width: 150,
                              color: allInsightsColor[4],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.fastingExplained![1].title
                                          .toString())),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: font18Textbold(text: "Healthy Movement")),
                          InkWell(
                              onTap: () {
                                Get.to(() => AllInsightsScreen(
                                      title: 'Healthy Movement',
                                      model: model!.healthyMovement!,
                                    ));
                              },
                              child: const Text("see all")),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (() {
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.healthyMovement![0].toJson()["option"]
                                        )));
                            }),
                            child: InsightsDashBoardContainer(
                              color2: allInsightsColor[4],
                              height: 150,
                              width: 150,
                              color: insightsColor[2],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.healthyMovement![0].title
                                          .toString())),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.healthyMovement![1].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              color2: abcFastingColors[1],
                              height: 150,
                              width: 150,
                              color: insightsColor[1],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.healthyMovement![1].title
                                          .toString())),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          font18Textbold(text: "Healthy Weight"),
                          InkWell(
                              onTap: () {
                                Get.to(() => AllInsightsScreen(
                                      title: 'Healthy Weight',
                                      model: model!.healthyWeight!,
                                    ));
                              },
                              child: const Text("see all")),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.healthyWeight![0].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              color2: insightsColor[0],
                              height: 150,
                              width: 150,
                              color: fastingProtocolColors[5],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.healthyWeight![0].title
                                          .toString())),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.healthyWeight![1].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              color2: allInsightsColor[4],
                              height: 150,
                              width: 150,
                              color: fastingProtocolColors[4],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.healthyWeight![1].title
                                          .toString())),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          font18Textbold(text: "Getting Started"),
                          InkWell(
                              onTap: () {
                                Get.to(() => AllInsightsScreen(
                                      title: 'Getting Started',
                                      model: model!.gettingStarted!,
                                    ));
                              },
                              child: const Text("see all")),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.gettingStarted![0].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              height: 150,
                              color2: allInsightsColor[6],
                              width: 150,
                              color: fastingProtocolColors[3],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.gettingStarted![0].title
                                          .toString())),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomStoryView(
                                          data:  model!.gettingStarted![1].toJson()["option"]
                                        )));
                            },
                            child: InsightsDashBoardContainer(
                              color2: fastingProtocolColors[2],
                              height: 150,
                              width: 150,
                              color: allInsightsColor[6],
                              widget: Center(
                                  child: font16Textbold(
                                      text: model!.gettingStarted![1].title
                                          .toString())),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //         child: font18Textbold(
                      //             text: "Productivity and Fasting")),
                      //     const Text("see all"),
                      //   ],
                      // ),
                      // const SizedBox(height: 10),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     InsightsDashBoardContainer(
                      //       height: 150,
                      //       color2: insightsColor[1],
                      //       width: 150,
                      //       color: fastingProtocolColors[2],
                      //       widget: Center(
                      //           child: font16Textbold(
                      //               text:
                      //                   'How Does Fasting Affect Productivity')),
                      //     ),
                      //     InsightsDashBoardContainer(
                      //       color2: insightsColor[0],
                      //       height: 150,
                      //       width: 150,
                      //       color: fastingProtocolColors[4],
                      //       widget: Center(
                      //           child: font16Textbold(
                      //               text: 'How Fasting Influences Our Mental')),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     font18Textbold(text: "Getting Started"),
                      //     const Text("see all"),
                      //   ],
                      // ),
                      // const SizedBox(height: 10),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     InsightsDashBoardContainer(
                      //       color2: allInsightsColor[2],
                      //       height: 150,
                      //       width: 150,
                      //       color: allInsightsColor[1],
                      //       widget: Center(
                      //           child: font16Textbold(
                      //               text: 'First Lauch of the Poonam Dua')),
                      //     ),
                      //     InsightsDashBoardContainer(
                      //       color2: allInsightsColor[0],
                      //       height: 150,
                      //       width: 150,
                      //       color: allInsightsColor[1],
                      //       widget: Center(
                      //           child: font16Textbold(
                      //               text: 'First Fasting Start')),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     font18Textbold(text: "Fasting Challenge"),
                      //     const Text("see all"),
                      //   ],
                      // ),
                      // const SizedBox(height: 10),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     InsightsDashBoardContainer(
                      //       color2: allInsightsColor[1],
                      //       height: 150,
                      //       width: 150,
                      //       color: allInsightsColor[5],
                      //       widget: Center(
                      //           child: font16Textbold(
                      //               text: 'Welcome to Your 30-day Fasting')),
                      //     ),
                      //     InsightsDashBoardContainer(
                      //       color2: allInsightsColor[6],
                      //       height: 150,
                      //       width: 150,
                      //       color: allInsightsColor[3],
                      //       widget: Center(
                      //           child: font16Textbold(
                      //               text:
                      //                   'Day 1: Intro to Your Fasting Schedule')),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     font18Textbold(text: "Eat Healthy"),
                      //     const Text("see all"),
                      //   ],
                      // ),
                      // const SizedBox(height: 10),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     InsightsDashBoardContainer(
                      //       height: 150,
                      //       color2: allInsightsColor[6],
                      //       width: 150,
                      //       color: allInsightsColor[5],
                      //       widget: Center(
                      //           child: font16Textbold(
                      //               text:
                      //                   'Paint Your Days With Colorful Foods')),
                      //     ),
                      //     InsightsDashBoardContainer(
                      //       color2: allInsightsColor[4],
                      //       height: 150,
                      //       width: 150,
                      //       color: allInsightsColor[3],
                      //       widget: Center(
                      //           child: font16Textbold(
                      //               text:
                      //                   'This is Exactly How to Build a Healthy Plate')),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
          ),
        ));
  }
}
