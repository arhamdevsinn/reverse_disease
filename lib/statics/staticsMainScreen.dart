import 'dart:developer';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/profile/settingScreen.dart';
import 'package:fitness_app_flutter/statics/fastingTab.dart';
import 'package:fitness_app_flutter/statics/weightTab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../repository/fastingPref/fasting_history_pref.dart';
import '../widgets/customShadowContainer.dart';
import 'hydrationTab.dart';

class StaticsMainScreen extends StatefulWidget {
  const StaticsMainScreen({Key? key}) : super(key: key);

  @override
  State<StaticsMainScreen> createState() => _StaticsMainScreenState();
}

class _StaticsMainScreenState extends State<StaticsMainScreen> {
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            font28Textbold(text: "Statistics"),
            const SizedBox(height: 20),
            CustomShadowContainer(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<List>(
                    future: FastingHistoryPref.readFastingHistory("fastingHistory"),
                      builder: (context,snapshot) {
                          if(snapshot.hasData && snapshot.data!=null){
                      int totalFast=0;
                      var longestFast=int.parse( snapshot.data![0]["fastingDuration"].substring(0,2));
                      if(snapshot.hasData){
                      

                      }
                        for(int i=0;i<snapshot.data!.length;i++){
                                 totalFast=i+1;
                                 for(int j=i+1;j<snapshot.data!.length;j++){
                                  if(int.parse( snapshot.data![i]["fastingDuration"].substring(0,2))<int.parse( snapshot.data![j]["fastingDuration"].substring(0,2))){
                                   longestFast=int.parse( snapshot.data![i]["fastingDuration"].substring(0,2));
                                  }
                                 }
                        }
                        String hour=longestFast.toString();
                        List listData=[
                          totalFast,
                          longestFast.toString().padRight(2,"h"),
                        ];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              // snapshot.data!.length,
                              listData.length,
                              (index) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      font16Textbold(
                                        // text: statisticsTitle[index]
                                        text: listData[index].toString()
                                        ),
                                      const SizedBox(height: 10),
                                      font12Textnormal(
                                          text: statisticssubTitle[index],
                                          color: blackcolor.withOpacity(0.5))
                                    ],
                                  )),
                        );
                          }
                          else{
                            return LinearProgressIndicator(color: themeColor,);
                          }
                      }
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            font20Textbold(text: 'Health categories'),
            _tabSection(context),
          ],
        ),
      )),
    );
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: TabBar(
                indicatorColor: themeColor,
                isScrollable: true,
                labelColor: themeColor,
                unselectedLabelColor: blackcolor.withOpacity(0.5),
                tabs: const [
                  Tab(text: "Fasting"),
                  Tab(text: "Hydration"),
                  Tab(text: "Weight"),
                ]),
          ),
          SizedBox(
            //Add this to give height
            height: MediaQuery.of(context).size.height,
            child: const TabBarView(children: [
              FastingTabScreen(),
              HydrationTabScreen(),
              WeightTabScreen(),
            ]),
          ),
        ],
      ),
    );
  }
}
