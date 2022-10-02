import 'dart:convert';
import 'dart:developer';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/model/daysModel.dart';
import 'package:fitness_app_flutter/provider/selcected_hours.dart';
import 'package:fitness_app_flutter/timerScreens/timerMainScreen.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:fitness_app_flutter/widgets/customShadowContainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/snakbar.dart';

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
  void initState() {
    super.initState();
    fun();
  }

  fun() async {
    await storeDaysModelData();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderHourSelectd>(context, listen: false);
    // fun();
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
              check = true;
              int hour = int.parse(provider.housSelectd.substring(0, 2));
              time = DateFormat("jm").format(DateTime(0, 0, 0, x.hour, x.minute)
                  .add(Duration(hours: hour)));
              print("The picked time is: ${x}");
            });
          }),
          const SizedBox(height: 10),
          _buildTimePick("End", true, endTime, (x) {
            setState(() {
              endTime = x;
              check = false;
              int hour = int.parse(provider.housSelectd.substring(0, 2));
              time = DateFormat("jm").format(DateTime(0, 0, 0, x.hour, x.minute)
                  .add(Duration(hours: hour)));

              print("The picked time isv: ${x})}");
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
                  text: check == false ? time : startTime.format(context),
                ),
                const SizedBox(width: 10),
                font18Textbold(text: "-"),
                const SizedBox(width: 10),
                font18Textbold(
                  text: check == true ? time : endTime.format(context),
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
                SizedBox(
                  height: 100,
                  child: FutureBuilder<List>(
                      future: getDaysModelData(),
                      builder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              // daysModel.daysModelData.length,
                              snapshot.data != []
                                  ? snapshot.data!.length
                                  : daysModel.daysModelData.length,
                              (index) => InkWell(
                                    onTap: () {
                                      setState(() {
                                        var itemLength;
                                        for (int i = 0;
                                            i < snapshot.data!.length;
                                            i++) {
                                          itemLength = i;
                                        }
                                        if (itemLength <
                                                snapshot.data!.length - 1 ||
                                            itemLength <
                                                daysModel.daysModelData.length -
                                                    1) {
                                          daysModel.daysModelData[index]
                                                  ["onSelect"] =
                                              !daysModel.daysModelData[index]
                                                  ["onSelect"];
                                          var data = {
                                            "index": index,
                                            "title": daysModel
                                                .daysModelData[index]["title"],
                                            "onSelect":
                                                daysModel.daysModelData[index]
                                                    ["onSelect"],
                                          };
                                          storeDaysModelData(value: data);
                                        }
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            // daysModel.daysModelData[index]
                                            // ["onSelect"]
                                            snapshot.data?[index]["onSelect"]
                                                ? themeColor
                                                : Colors.grey.withOpacity(0.2),
                                      ),
                                      child: font12Textnormal(
                                          text: daysModel.daysModelData[index]
                                              ["title"],
                                          color: daysModel.daysModelData[index]
                                                  ["onSelect"]
                                              ? whitecolor
                                              : blackcolor),
                                    ),
                                  )),
                        );
                      }),
                ),
                const SizedBox(height: 30),
                CustomButton(
                    buttonText: "Set",
                    onTap: () {
                      check == null
                          ? showSnackbar(context, "Select start time")
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TimerMainScreen(
                                    startT: check == false
                                        ? time
                                        : startTime.format(context),
                                    endT: check == true
                                        ? time
                                        : endTime.format(context),
                                  )));
                    },
                    color: themeColor)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future selectedTime(BuildContext context, bool ifPickedTime,
      TimeOfDay initialTime, Function(TimeOfDay) onTimePicked) async {
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

  storeDaysModelData({value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool flag = true;
    // var data = pref.getString("daysModel");
    var decodedData = await getDaysModelData();

    if (decodedData != [] && decodedData.isNotEmpty) {
      log("ggggggggggggggg ${decodedData}");
      for (int i = 0; i < decodedData.length; i++) {
        if (decodedData[i]["title"] == value["title"]) {
          decodedData[i]["onSelect"] = value["onSelect"];
          pref.setString("daysModel", jsonEncode(decodedData));
        }
      }
    } else {
      pref.setString("daysModel", jsonEncode(daysModel.daysModelData));
    }
  }

  Future<List> getDaysModelData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = preferences.getString("daysModel");
    if (data != null) {
      return jsonDecode(data);
    }
    return [];
  }
}
