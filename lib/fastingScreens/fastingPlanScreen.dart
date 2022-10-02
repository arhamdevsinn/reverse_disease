import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:fitness_app_flutter/widgets/customShadowContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../model/fastingModel/fasting_model.dart';
import '../provider/selcected_hours.dart';
import '../provider/timer_status.dart';
import '../repository/fastingPref/fasting_history_logic.dart';
import '../timerScreens/timerMainScreen.dart';
import '../utils/dialogue.dart';
import 'fastingProtocolScreen.dart';
extension on DateTime {
  String myCusTime() {
    return "${this.hour}:${this.minute}.${this.second}";
  }

  int hourInInt() {
    return this.hour;
  }

  int minInInt() {
    return this.minute;
  }

  int SecondInInt() {
    return this.second;
  }
}
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


  final _scrollController = ScrollController();
  bool _isHours = true;
  bool onTimerStart = false;
 var startingFastingTime;
 String?   displayTime;
  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        var hoursData = Provider.of<ProviderHourSelectd>(context, listen: false);

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
                        children:  [
                          Text(
                            hoursData.housSelectd,
                            style:const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                         const SizedBox(height: 10),
                       const   Text(
                            "Fasting protocol",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                         const SizedBox(height: 20),
                         const Text(
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
                          StreamBuilder<Map<String, dynamic>?>(
                            stream: FlutterBackgroundService().on("update"),
                            builder: (context, snapshot) {
                             

                              return Consumer<TimerStatus>(
                                  builder: (context, value, child) {
                                    if(snapshot.hasData){
                                 displayTime=    DateFormat.Hms().format( DateTime.parse(
                                      snapshot.data?['current_date'])).toString() ;
                                    }
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    (snapshot.data?["current_date"] != null &&
                                            value.timerStatusValue == true)
                                        ? Text(
                                            // DateTime.parse(snapshot
                                            //         .data!['current_date'])
                                            //     .myCusTime(),
                                            DateFormat.Hms().format( DateTime.parse(
                                      snapshot.data?['current_date'])).toString() ,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : const Text(
                                            "00:00:00",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                  ],
                                );
                              });
                           
                            },
                          ),
                          Consumer<TimerStatus>(
                              builder: (context, value, child) {
                            return Container(
                              child: value.timerStatusValue == true
                                  ? MaterialButton(
                                      shape: const StadiumBorder(),
                                      color: themeColor,
                                      onPressed: ()async {
                                       
                                       final service = FlutterBackgroundService();
                                var isRunning = await service.isRunning();
                                if (isRunning) {
                                  service.invoke("stopService");
                                } else {
                                  service.startService();
                                }
                                 saveDataDialog(
                                    context: context,
                                    fastingTime: displayTime??"",
                                    startTime: startingFastingTime);
                                        value.setTimerStatus(false);
                                      },
                                      child: font16Textbold(
                                          text: "Cancel", color: whitecolor))
                                  : MaterialButton(
                                      shape: const StadiumBorder(),
                                      color: themeColor,
                                      onPressed: () {
                                          startingFastingTime = DateFormat.yMd()
                                    .add_jm()
                                    .format(DateTime.now());             
                                        setTime();
                                        initializeService();
                                       value.setTimerStatus(true);
                                      },
                                      child: font16Textbold(
                                          text: "Start", color: whitecolor)),
                            );
                          })
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
