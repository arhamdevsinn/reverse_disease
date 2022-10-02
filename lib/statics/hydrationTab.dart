import 'dart:developer';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../repository/sharedPref/shared_pref.dart';

class HydrationTabScreen extends StatefulWidget {
  const HydrationTabScreen({Key? key}) : super(key: key);

  @override
  State<HydrationTabScreen> createState() => _HydrationTabScreenState();
}

class _HydrationTabScreenState extends State<HydrationTabScreen> {
  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [
    ];
    return FutureBuilder<List>(
   future: HydrationPreferences.readHydrationData("hydration"),      
      builder: (context,snapshot) {
        if(snapshot.hasData&&snapshot.data!=null){
       log(snapshot.data.toString());
       for(int i=0;i<snapshot.data!.length;i++){
        data.add(_SalesData(snapshot.data![i]['date'], snapshot.data![i]['quantity']));
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
                    dataLabelMapper: ((datum, index) {
                      for(int i=index;i<snapshot.data!.length;i++){

                      return "${snapshot.data![i]["quantity"]} ml";
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
          return const Center(child: LinearProgressIndicator(),);
        }
      }
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final int sales;
}
