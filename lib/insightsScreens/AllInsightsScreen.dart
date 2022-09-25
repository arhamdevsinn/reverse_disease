import 'dart:convert';
import 'dart:developer';

import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/insightsScreens/insightScreen1.dart';
import 'package:fitness_app_flutter/model/insight.dart';
import 'package:flutter/material.dart';

import '../constants/textHelper.dart';

class AllInsightsScreen extends StatefulWidget {
  String title;
  List? model;
  AllInsightsScreen({super.key, required this.title,this.model});
  @override
  State<AllInsightsScreen> createState() => _AllInsightsScreenState();
}

class _AllInsightsScreenState extends State<AllInsightsScreen> { 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
          backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              font28Textbold(text: widget.title),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: widget.model!.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = widget.model![index];
                  
              
                  return InkWell(
                    onTap: () {
                      // log("${data.toJson()["option"]}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                      //           // fastingProtocolScreens[index]),
                                CustomStoryView(
                                  data:data.toJson()["option"],
                                ))
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: abcFastingColors[index],
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: font18Textbold(
                                
                                text: data.title,
                                )
                                ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
