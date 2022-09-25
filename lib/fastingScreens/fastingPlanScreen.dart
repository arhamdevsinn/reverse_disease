import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:fitness_app_flutter/widgets/customShadowContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'fastingProtocolScreen.dart';

class fastingPlanScreen extends StatefulWidget {
  const fastingPlanScreen({Key? key}) : super(key: key);

  @override
  State<fastingPlanScreen> createState() => _fastingPlanScreenState();
}

class _fastingPlanScreenState extends State<fastingPlanScreen> {
  DateTime? selectedDate;
  bool showMeal = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        showMeal = true;
      });
    }
  }

  bool showTimerCount = false;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onStop: () {
      print('onStop');
    },
    onEnded: () {
      print('onEnded');
    },
  );

  final _scrollController = ScrollController();
  bool _isHours = true;
  bool onTimerStart = false;

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
    _stopWatchTimer.fetchStop.listen((value) => print('stop from stream'));
    _stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackButton(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "18:6",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Fasting protocol",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "This is your personal plan. You have a schedule, food recommendations, meal plan, etc.",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomShadowContainer(
                widget: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      font14Textnormal(text: "Remaining eating time"),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StreamBuilder<int>(
                            stream: _stopWatchTimer.rawTime,
                            initialData: _stopWatchTimer.rawTime.value,
                            builder: (context, snap) {
                              final value = snap.data!;
                              final displayTime = StopWatchTimer.getDisplayTime(
                                  value,
                                  milliSecond: false,
                                  hours: _isHours);
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    displayTime,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              );
                            },
                          ),
                          Container(
                            child: showTimerCount == true
                                ? MaterialButton(
                                    shape: const StadiumBorder(),
                                    color: themeColor,
                                    onPressed: () {
                                      setState(() {
                                        _stopWatchTimer.onExecute
                                            .add(StopWatchExecute.stop);
                                        showTimerCount = false;
                                      });
                                    },
                                    child: font16Textbold(
                                        text: "Cancel", color: whitecolor))
                                : MaterialButton(
                                    shape: const StadiumBorder(),
                                    color: themeColor,
                                    onPressed: () {
                                      setState(() {
                                        _stopWatchTimer.onExecute
                                            .add(StopWatchExecute.start);
                                        onTimerStart = true;
                                      });
                                    },
                                    child: font16Textbold(
                                        text: "Start", color: whitecolor)),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          font16Textbold(text: "Eating"),
                          font16Textbold(text: "Fasting"),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          font14Textnormal(text: "05:055 pm"),
                          font14Textnormal(text: "06:09 pm"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: CustomShadowContainer(
                    widget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    font16Textbold(
                        text: selectedDate != null
                            ? DateFormat("yyyy-MM-dd").format(selectedDate!)
                            : "Select date for meat plan"),
                    const Icon(Icons.calendar_month),
                  ],
                )),
              ),
            ),
            showMeal == true
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomShadowContainer(
                        widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Center(child: font18Textbold(text: "Meal Plan")),
                        const SizedBox(height: 10),
                        font14Textbold(text: "03:00 pm - 9:00 am"),
                        const SizedBox(height: 10),
                        customMealColor(insightsColor[0], "Fasting window"),
                        const SizedBox(height: 10),
                        font14Textnormal(
                            text:
                                "Water, tea & coffee without sugar, turmeric water, lemon or lime water, diluted apple cider vinegar"),
                        const SizedBox(height: 10),
                        font14Textbold(text: "9:00 am - 10:00 am"),
                        const SizedBox(height: 10),
                        customMealColor(insightsColor[1], "First meal"),
                        const SizedBox(height: 10),
                        font14Textnormal(text: "Avocado & Cheese Salad"),
                        const SizedBox(height: 10),
                        customMealColor(insightsColor[2], "Snack"),
                        const SizedBox(height: 10),
                        font14Textnormal(text: "2 Kiwis"),
                        const SizedBox(height: 10),
                        font14Textbold(text: "2:00 pm - 3:00 pm"),
                        const SizedBox(height: 10),
                        customMealColor(insightsColor[1], "Last meal"),
                        const SizedBox(height: 10),
                        font14Textnormal(text: "Creamy Pesto Scrambled Eggs"),
                      ],
                    )),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: InkWell(
                onTap: () {
                  Get.to(() => ChooseFastingProtocolScreen(checkBool: true,));
                },
                child: CustomShadowContainer(
                    widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    font18Textbold(text: "My fasting protocol: 20:4"),
                    const SizedBox(width: 10),
                    const Icon(Icons.edit)
                  ],
                )),
              ),
            ),
            const SizedBox(height: 20),
          ],
        )),
      ),
    );
  }

  customMealColor(Color color, String text) {
    return Container(
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      height: 40,
      width: 140,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
      child: Center(
          child: font14Textbold(text: text, textAlign: TextAlign.center)),
    );
  }
}
