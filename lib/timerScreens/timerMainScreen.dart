import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/model/fastingModel/fasting_model.dart';
import 'package:fitness_app_flutter/provider/selcected_hours.dart';
import 'package:fitness_app_flutter/repository/fastingPref/fasting_history_logic.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:fitness_app_flutter/widgets/customShadowContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../fastingScreens/fastingProtocolScreen.dart';
import 'eatingWindowScreen.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: false,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');

  return true;
}

@pragma('vm:entry-point')
void onStart(
  ServiceInstance service,
) async {
  DartPluginRegistrant.ensureInitialized();
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

  service.on('stopService').listen((event) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("timerstate", false);
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    _stopWatchTimer.dispose();
    service.stopSelf();
  });

  var displayTime;
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    _stopWatchTimer.rawTime.listen((value) {
      displayTime = StopWatchTimer.getDisplayTime(value, hours: true);
      print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}');
    });

    _stopWatchTimer.minuteTime.listen((value) {
      return print("value: $value");
    });
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
    _stopWatchTimer.fetchStop.listen((value) => print('stop from stream'));
    _stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);

    service.invoke(
      'update',
      {
        "time": displayTime,
      },
    );
  });
}

class TimerMainScreen extends StatefulWidget {
  const TimerMainScreen({Key? key}) : super(key: key);

  @override
  State<TimerMainScreen> createState() => _TimerMainScreenState();
}

DateTime? selectedDate;
bool _isHours = true;
bool onTimerStart = false;

class _TimerMainScreenState extends State<TimerMainScreen> {
  bool showTimerCount = false;

  // final StopWatchTimer _stopWatchTimer = StopWatchTimer(
  //   mode: StopWatchMode.countUp,
  //   onChange: (value) => print('onChange $value'),
  //   onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
  //   onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  //   onStop: () {
  //     print('onStop');
  //   },
  //   onEnded: () {
  //     print('onEnded');
  //   },
  // );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _stopWatchTimer.rawTime.listen((value) {
    //   print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}');
    // });

    // _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    // _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    // _stopWatchTimer.records.listen((value) => print('records $value'));
    // _stopWatchTimer.fetchStop.listen((value) => print('stop from stream'));
    // _stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    // await _stopWatchTimer.dispose();
  }

  var startingFastingTime;
  var endingFastingTime;
  var displayTime;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderHourSelectd>(context, listen: false);
    int endcounter = DateTime.now().millisecondsSinceEpoch + 43200 * 1000;
    TimeOfDay startTime = TimeOfDay.now();
    TimeOfDay endTime = TimeOfDay.now();
    var today = DateTime.now();
    var today2 = DateFormat("jm").format(today);
    int hour = int.parse(provider.housSelectd.substring(0, 2));
    var endToday = DateFormat("jm").format(today.add(Duration(hours: hour)));

    log("time$today2");
    log("differ${endToday}");

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Center(child: font28Textbold(text: "Get ready to fast")),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: InkWell(
                  onTap: () {
                    Get.to(() => ChooseFastingProtocolScreen(
                          checkBool: false,
                        ));
                  },
                  child: CustomShadowContainer(
                      widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // font16Textbold(text: "My fasting protocol: 20:4"),
                      font16Textbold(
                          text: "My fasting protocol: ${provider.housSelectd}"),

                      const SizedBox(width: 10),
                      const Icon(Icons.edit)
                    ],
                  )),
                ),
              ),
              Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: blackcolor.withOpacity(0.1)),
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Get.to(() => EatingWindowScreen());
                  },
                  child: Container(
                      height: 170,
                      width: 170,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: whitecolor),
                      child: showTimerCount == true
                          ? StreamBuilder<Map<String, dynamic>?>(
                              stream: FlutterBackgroundService().on('update'),
                              builder: (context, snap) {
                                if (!snap.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                displayTime = snap.data?['time'];
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        displayTime ?? "00:00:00",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                font16Textnormal(text: "Fasting time"),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // font14Textbold(
                                    //   text: startTime.format(context),
                                    // ),
                                    font14Textbold(
                                      text: today2,
                                    ),
                                    const SizedBox(width: 5),
                                    font14Textbold(text: "-"),
                                    const SizedBox(width: 5),
                                    // font14Textbold(
                                    //   text: endTime.format(context),
                                    // ),
                                    font14Textbold(
                                      text: endToday,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: showTimerCount == true
                    ? CustomButton(
                        buttonText: "End fast",
                        onTap: () async {
                          print(displayTime);
                          // _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                          showTimerCount = false;
                          endingFastingTime =
                              DateFormat.yMd().add_jm().format(DateTime.now());
                          var data = {
                            "fastingDuration": displayTime,
                            "startFast": startingFastingTime,
                            "endFast": endingFastingTime,
                          };
                          FastingHistoryModel model =
                              FastingHistoryModel.fromJson(data);
                          FastingHistoryLogic.addFastigLogic(
                              data: model,
                              context: context,
                              name: "fastingHistory");
                          final service = FlutterBackgroundService();
                          var isRunning = await service.isRunning();
                          if (isRunning) {
                            service.invoke("stopService");
                          } else {
                            service.startService();
                          }
                          setState(() {});
                        },
                        color: themeColor)
                    : CustomButton(
                        buttonText:
                            "Start ${provider.housSelectd.substring(0, 2)}h fast ",
                        onTap: () async {
                          startingFastingTime =
                              DateFormat.yMd().add_jm().format(DateTime.now());
                          showDatePicker();
                        },
                        color: themeColor),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: CustomShadowContainer(
                    widget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      font18Textbold(text: "Tips for fasting time"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: font16Textnormal(text: fastingTip),
                      )
                    ],
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            color: whitecolor,
            height: 400,
            child: Column(
              children: [
                Container(
                  height: 300,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    onDateTimeChanged: (value) {
                      if (value != null && value != selectedDate) {
                        setState(() {
                          selectedDate = value;
                        });
                      }
                    },
                    initialDateTime: DateTime.now(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomButton(
                      buttonText: "Set",
                      onTap: () async {
                        showTimerCount = true;
                        // _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setBool("timerstate", true);
                        WidgetsFlutterBinding.ensureInitialized();
                        await initializeService();
                        Navigator.pop(context);
                        setState(() {});
                      },
                      color: themeColor),
                )
              ],
            ),
          );
        });
  }
}
/////////////////////////////////////////////
///
//  StreamBuilder<int>(
//                               stream: _stopWatchTimer.rawTime,
//                               initialData: _stopWatchTimer.rawTime.value,
//                               builder: (context, snap) {
//                                 print(snap.data);
//                                 final value = snap.data!;
//                                  log("dddd ${value}");
//                                 displayTime = StopWatchTimer.getDisplayTime(
//                                     value,
//                                     second: true,
//                                     minute: true,
//                                     milliSecond: false,
//                                     hours: _isHours);
//                                     log("ddfdf ${displayTime}");
//                                 return Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: const EdgeInsets.all(8),
//                                       child: Text(
//                                         displayTime,
//                                         style: const TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             )