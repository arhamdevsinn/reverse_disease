import 'dart:developer';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/customBotttomNav.dart';
import 'package:fitness_app_flutter/homeScreens/dashBoardScreen.dart';
import 'package:fitness_app_flutter/hydrationScreens/hydrationMainScreen.dart';
import 'package:fitness_app_flutter/hydrationScreens/show_history.dart';
import 'package:fitness_app_flutter/model/hydration-model.dart/hydration_model.dart';
import 'package:fitness_app_flutter/repository/sharedPref/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/strings.dart';
import '../constants/textHelper.dart';
import '../utils/snakbar.dart';

class HydrationHistory extends StatefulWidget {
  const HydrationHistory({super.key});

  @override
  State<HydrationHistory> createState() => _HydrationHistoryState();
}

class _HydrationHistoryState extends State<HydrationHistory> {
  @override
  void initState() {
    super.initState();

    hydrationData2();
  }

  List<dynamic> listValue = [];
  List<dynamic> listValue2 = [];
  Future hydrationData2() async {
    await HydrationPreferences.readHydrationData("hydration2").then((value) {
      if (value.isNotEmpty) {
        value.map((e) {
          listValue.add(value);

          log("$value");
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0.0,
                snap: true,
                floating: true,
                // pinned: true,
                flexibleSpace: const FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Hydration history",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      )),
                  expandedTitleScale: 1.8,
                ),
                expandedHeight: 100,
                backgroundColor: Colors.white24,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  tooltip: 'Menu',
                  onPressed: () {
                    Get.to(CustomBottomNavigationBar());
                  },
                ),
              ),
            ];
          },
          body: SafeArea(
            child: FutureBuilder<List>(
                future: HydrationPreferences.readHydrationData("hydration"),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "No history added",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          minWidth: 100,
                          color: themeColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            Get.to(const AddHydrationScreen());
                          },
                          child: const Text(
                            "add",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return ListView.builder(
                    // reverse: true,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      HydrationModel model =
                          HydrationModel.fromJson(snapshot.data![index]);

                      return GestureDetector(
                        onTap: () {
                          Get.to(ShowHistory(
                            liquid: model.liquid,
                            date: model.date,
                            totalQuatity: model.quantity,
                          ));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          color: fastingProtocolColors[0],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                font18Textbold(text: model.quantity.toString()),
                                font16Textbold(
                                    text: model.date.toString(),
                                    textAlign: TextAlign.end,
                                    color: blackcolor.withOpacity(0.3))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          )),
    );
  }
}
