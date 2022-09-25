import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/questionsScreen/subscriptionScreen.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlanReadyScreen extends StatefulWidget {
   var gender;
  var primaryGoal;
  var bodyType;
  var targetBodyType;
  var lastTimeHappyness;
  Map? activityLevel;
  var height;
  var weight;
  var targetWeight;
  var age;
  var meditation;
  Map? dietFollow;
  var firstMeal; 
  var lastMeal;
  var occasion;
  var eventDate;
   PlanReadyScreen({Key? key,
   this.gender,
    this.bodyType,
    this.primaryGoal,
    this.targetBodyType,
    this.lastTimeHappyness,
    this.activityLevel,
    this.height,
    this.weight,
    this.targetWeight,
    this.age,
    this.meditation,
    this.dietFollow,
    this.firstMeal,
    this.lastMeal,
    this.occasion, 
    this.eventDate
    } 
  ) : super(key: key);

  @override
  State<PlanReadyScreen> createState() => _PlanReadyScreenState();
}

class _PlanReadyScreenState extends State<PlanReadyScreen> {
  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [
      _SalesData('', 35),
    ];
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          const SizedBox(height: 20),
          font28Textbold(text: "Your personal\n plan is ready!"),
          const SizedBox(height: 20),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              legend: Legend(isVisible: false),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                StackedBarSeries<_SalesData, String>(
                    color: themeColor,
                    dataSource: data,
                    spacing: 0.98,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Sales',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: false)),
              ]),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
                buttonText: "Continue",
                onTap: () {
                  Get.to(() =>  SubscriptionScreen(

                     gender: widget.gender,
                                primaryGoal: widget.primaryGoal,
                                bodyType: widget.bodyType,
                                targetBodyType: widget.targetBodyType,
                                lastTimeHappyness: widget.lastTimeHappyness,
                                activityLevel: widget.activityLevel,
                                height: widget.height,
                                weight: widget.weight,
                                targetWeight: widget.targetWeight,
                                age: widget.age,
                                meditation: widget.meditation,
                                dietFollow: widget.dietFollow,
                                firstMeal: widget.firstMeal,
                                lastMeal: widget.lastMeal,
                                occasion: widget.occasion,
                                eventDate: widget.eventDate
                  ));
                },
                color: themeColor),
          )
        ]),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
