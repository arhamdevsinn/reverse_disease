import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/profile/settingScreen.dart';
import 'package:fitness_app_flutter/statics/fastingTab.dart';
import 'package:fitness_app_flutter/statics/weightTab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  font16Textbold(text: statisticsTitle[index]),
                                  const SizedBox(height: 10),
                                  font12Textnormal(
                                      text: statisticssubTitle[index],
                                      color: blackcolor.withOpacity(0.5))
                                ],
                              )),
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
