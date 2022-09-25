import 'dart:developer';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/model/daysModel.dart';
import 'package:fitness_app_flutter/provider/selcected_hours.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:fitness_app_flutter/widgets/customShadowContainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EatingWindowScreen extends StatefulWidget {
  @override
  State<EatingWindowScreen> createState() => EatingWindowScreenState();
}

class EatingWindowScreenState extends State<EatingWindowScreen> {
  TimeOfDay endTime = TimeOfDay.now();
  TimeOfDay startTime = TimeOfDay.now();
  DaysModel daysModel = DaysModel();
  
    var time;
    bool? check;
  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<ProviderHourSelectd>(context,listen: false);
 
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: whitecolor,
        leading: const BackButton(color: blackcolor),
        title: font18Textbold(text: "Eating window"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: font18Textmedium(text: "Eating time")),
          const SizedBox(height: 20),
          _buildTimePick("Start", true, startTime, (x) {
            setState(() {
              startTime = x;
            
             
              print("The picked time is: ${endTime.replacing(hour: 23-1,minute: x.minute).format(context)}");
            });
          }),
          const SizedBox(height: 10),
          _buildTimePick("End", true, endTime, (x) {
            setState(() {
              endTime = x;
              
              print("The picked time isv: ${startTime.replacing(hour: x.hour+22,minute: x.minute)}");
            });
          }),

          const SizedBox(height: 20),
                             Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: CustomShadowContainer(
                widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                font18Textbold(
                  // text: startTime.format(context),
                  text: check==false? startTime.replacing(hour:2,minute:endTime.minute ).format(context):startTime.format(context),
                ),
                
                const SizedBox(width: 10),
                font18Textbold(text: "-"),
                const SizedBox(width: 10),
                font18Textbold(
                  // text: endTime.format(context),
                 text: check==true? endTime.replacing(hour:23-1,minute:endTime.minute  ).format(context):endTime.format(context),
                
                ),
              ],
            )),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                font18Textbold(text: "Treat days"),
                const SizedBox(height: 10),
                font16Textnormal(
                    text: "On those days you take a break from fasting. Yay!"),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      daysModel.daysModelData.length,
                      (index) => InkWell(
                            onTap: () => {
                              setState(() {
                                daysModel.daysModelData[index]["onSelect"] =
                                    !daysModel.daysModelData[index]["onSelect"];
                              })
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: daysModel.daysModelData[index]
                                        ["onSelect"]
                                    ? themeColor
                                    : Colors.grey.withOpacity(0.2),
                              ),
                              child: font12Textnormal(
                                  text: daysModel.daysModelData[index]["title"],
                                  color: daysModel.daysModelData[index]
                                          ["onSelect"]
                                      ? whitecolor
                                      : blackcolor),
                            ),
                          )),
                ),
                const SizedBox(height: 30),
                CustomButton(buttonText: "Set", onTap: () {}, color: themeColor)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future selectedTime(BuildContext context, bool ifPickedTime,
      TimeOfDay initialTime, Function(TimeOfDay ) onTimePicked) async {
    var _pickedTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (_pickedTime != null) {
      onTimePicked(_pickedTime);
      
    }
  }

  Widget _buildTimePick(String title, bool ifPickedTime, TimeOfDay currentTime,
      Function(TimeOfDay) onTimePicked) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            title,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
            child: Text(
              currentTime.format(context),
            ),
            onTap: () {
              selectedTime(context, ifPickedTime, currentTime, onTimePicked);
            },
          ),
        ),
      ],
    );
  }
}
