import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../repository/fastingPref/fasting_history_pref.dart';

class FastingTabScreen extends StatefulWidget {
  const FastingTabScreen({Key? key}) : super(key: key);

  @override
  State<FastingTabScreen> createState() => _FastingTabScreenState();
}

class _FastingTabScreenState extends State<FastingTabScreen> {
  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [
      // _SalesData('24.08', 5),
      // _SalesData('25.08', 28),
      // _SalesData('26.08', 34),
      // _SalesData('27.08', 32),
      // _SalesData('28.08', 37),
      // _SalesData('29.08', 23),
      // _SalesData('30.08', 26)
    ];
    return FutureBuilder<List>(
      future: FastingHistoryPref.readFastingHistory("fastingHistory"),
      builder: (context, snapshot) {
        log(snapshot.data![0]["endFast"]);
        log("ddd${DateFormat}");
        if(snapshot.hasData&&snapshot.data!=null){
        for(int i=0;i<snapshot.data!.length;i++){
               data.add(_SalesData(snapshot.data![i]["endFast"].substring(9,17),double.parse( snapshot.data![i]["fastingDuration"].substring(6,8))));
        }
        return Column(children: [
          const SizedBox(height: 20),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              legend: Legend(isVisible: false),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                StackedBarSeries<_SalesData, String>(
                    color: themeColor,
                    dataSource: data,
                    spacing: 0.7,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Sales',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: false)),
                StackedBarSeries<_SalesData, String>(
                    dataSource: data,
                    spacing: 0.7,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Sales',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
        ]);
        }
        else{
          return const Center(child: LinearProgressIndicator(color: themeColor,));
        }
      }
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
