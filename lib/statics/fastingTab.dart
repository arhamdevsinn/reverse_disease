import 'dart:developer';
import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    
    ];
    return FutureBuilder<List>(
      future: FastingHistoryPref.readFastingHistory("fastingHistory"),
      builder: (context,AsyncSnapshot snapshot) {
        if(snapshot.hasData&&snapshot.data!=null&&snapshot.data!=[]){
        print(snapshot.data);
        for(int i=0;i<snapshot.data!.length;i++){
               data.add(_SalesData(snapshot.data![i]["endFast"].substring(9,16),double.parse( snapshot.data![i]["fastingDuration"].substring(6,8))));
        }
        return Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    
                    dataLabelMapper: ((datum, index) {
                      for(int i=index;i<snapshot.data!.length;i++){

                      return snapshot.data[i]["fastingDuration"].toString();
                      }
                      // // print(index.toString()+"ddddd");
                    }),
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
