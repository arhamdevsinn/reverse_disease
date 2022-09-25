import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/hydrationScreens/alcoholTab.dart';
import 'package:fitness_app_flutter/hydrationScreens/coffeeTab.dart';
import 'package:fitness_app_flutter/hydrationScreens/juiceTab.dart';
import 'package:fitness_app_flutter/hydrationScreens/milkTab.dart';
import 'package:fitness_app_flutter/hydrationScreens/softDrinkTab.dart';
import 'package:fitness_app_flutter/hydrationScreens/teaTab.dart';
import 'package:fitness_app_flutter/hydrationScreens/waterTabScreen.dart';
import 'package:flutter/material.dart';


import '../constants/colors.dart';

class AddHydrationScreen extends StatefulWidget {
  const AddHydrationScreen({Key? key}) : super(key: key);

  @override
  State<AddHydrationScreen> createState() => _AddHydrationScreenState();
}

class _AddHydrationScreenState extends State<AddHydrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0.0,
        title: font18Textbold(text: "Hydration", color: whitecolor),
      ),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_tabSection(context)])),
    );
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: themeColor,
            child: TabBar(
                isScrollable: true,
                labelColor: whitecolor,
                unselectedLabelColor: Colors.white,
                indicatorColor: whitecolor,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelStyle:
                    const TextStyle(fontSize: 16, fontFamily: "Campton"),
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: "Campton"),
                tabs: [
                  Container(
                    height: 70,
                    child: Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Water"),
                          Image.asset(
                            "images/water.png",
                            height: 30,
                            color: whitecolor,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Coffee"),
                          Image.asset(
                            "images/coffee.png",
                            height: 30,
                            color: whitecolor,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Tea"),
                          Image.asset(
                            "images/tea.png",
                            height: 30,
                            color: whitecolor,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Juice"),
                          Image.asset(
                            "images/juice.png",
                            height: 30,
                            color: whitecolor,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Soft drinks"),
                          Image.asset(
                            "images/softdrink.png",
                            height: 30,
                            color: whitecolor,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Milk"),
                          Image.asset(
                            "images/milk.png",
                            height: 30,
                            color: whitecolor,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Alcohol"),
                          Image.asset(
                            "images/alcohol.png",
                            height: 30,
                            color: whitecolor,
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
          Container(
            //Add this to give height
            height: MediaQuery.of(context).size.height,
            child: const TabBarView(children: [
              WaterTabScreen(type: "Water",),
              CoffeeTabScreen(),
              TeaTabScreen(),
              JuiceTabScreen(),
              SoftDrinkTabScreen(),
              MilkTabScreen(),
              AlcoholTabScreen(),
            ]),
          ),
        ],
      ),
    );
  }
}
