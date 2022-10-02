import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
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
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time/time.dart';
import '../fastingScreens/fastingProtocolScreen.dart';
import '../provider/timer_status.dart';
import '../utils/dialogue.dart';
import 'eatingWindowScreen.dart';
import '';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground',
    'MY FOREGROUND SERVICE',
    description: 'This channel is used for important notifications.',
    importance: Importance.low,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
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
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString("hello", "world");

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  DateTime dataum;
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  DateTime timer = DateTime.now();
  SharedPreferences timeStore = await SharedPreferences.getInstance();
  DateTime data = DateTime.now() + 10.hours + 5.minutes;

  int houres = await timeStore.getInt("hour")!;
  int min = await timeStore.getInt("min")!;
  int sec = await timeStore.getInt("sec")!;
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        flutterLocalNotificationsPlugin.show(
          888,
          'COOL SERVICE',
          'Awesome ${(DateTime.now() - houres.hours - min.minutes - sec.seconds).myCusTime()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
      }
    }

    final deviceInfo = DeviceInfoPlugin();
    String? device;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
    }

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
    }

    service.invoke(
      'update',
      {
        "current_date":
            "${(DateTime.now() - houres.hours - min.minutes - sec.seconds)}",
        "device": device,
      },
    );
  });
}

setTime() async {
  SharedPreferences timeStore = await SharedPreferences.getInstance();
  await timeStore.setInt("min", DateTime.now().minInInt());
  await timeStore.setInt("hour", DateTime.now().hourInInt());
  await timeStore.setInt("sec", DateTime.now().SecondInInt());
  print("objectlllllllllllllllllllllllllllllllllDone");
}

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

class TimerMainScreen extends StatefulWidget {
  final startT;
  final endT;
  const TimerMainScreen({Key? key, this.startT, this.endT}) : super(key: key);
  @override
  State<TimerMainScreen> createState() => _TimerMainScreenState();
}

DateTime? selectedDate;
bool _isHours = true;
bool onTimerStart = false;

class _TimerMainScreenState extends State<TimerMainScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  var startingFastingTime;
  var endingFastingTime;
  // DateTime? displayTime;
    String? displayTime;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderHourSelectd>(context, listen: false);
    // int endcounter = DateTime.now().millisecondsSinceEpoch + 43200 * 1000;
    // TimeOfDay startTime = TimeOfDay.now();
    // TimeOfDay endTime = TimeOfDay.now();
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
                  child:
                      Consumer<TimerStatus>(builder: (context, value, child) {
                    return Container(
                        height: 170,
                        width: 170,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: whitecolor),
                        child: value.timerStatusValue == true
                            ? StreamBuilder<Map<String, dynamic>?>(
                                stream: FlutterBackgroundService().on('update'),
                                builder: (context, snap) {
                                  log("value is equal to ${value.timerStatusValue}");
                                  if (!snap.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                      color: themeColor,
                                    ));
                                  }
                                  // displayTime = DateTime.parse(
                                      // snap.data?['current_date']);
                                    displayTime=  DateFormat.Hms().format( DateTime.parse(
                                      snap.data?['current_date'])) ;
                                      // log("${}");
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          // displayTime?.myCusTime() ?? "",
                                          displayTime.toString(),
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
                                      font14Textbold(
                                        text: widget.startT ?? today2,
                                      ),
                                      const SizedBox(width: 5),
                                      font14Textbold(text: "-"),
                                      const SizedBox(width: 5),
                                      font14Textbold(
                                        text: widget.endT ?? endToday,
                                      ),
                                    ],
                                  ),
                                ],
                              ));
                  }),
                ),
              ),
              Consumer<TimerStatus>(builder: (context, value, child) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: value.timerStatusValue == true
                      ? CustomButton(
                          buttonText: "End fast",
                          onTap: () async {
                           saveDataDialog(
                                    context: context,
                                    // fastingTime: displayTime?.myCusTime(),
                                    fastingTime: displayTime,
                                    startTime: startingFastingTime);
                            final service = FlutterBackgroundService();
                            var isRunning = await service.isRunning();
                            if (isRunning) {
                              service.invoke("stopService");
                            } else {
                              service.startService();
                            }
                            value.setTimerStatus(false);
                          },
                          color: themeColor)
                      : CustomButton(
                          buttonText:
                              "Start ${provider.housSelectd.substring(0, 2)}h fast ",
                          onTap: () async {
                            startingFastingTime = DateFormat.yMd()
                                .add_jm()
                                .format(DateTime.now());
                            showDatePicker(value);
                          },
                          color: themeColor),
                );
              }),
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

  void showDatePicker(value) {
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
                        value.setTimerStatus(true);
                        log("value is equal to2 ${value.timerStatusValue}");
                        WidgetsFlutterBinding.ensureInitialized();
                        setTime();
                        initializeService();
                        Navigator.pop(context);
                        // setState(() {});
                      },
                      color: themeColor),
                )
              ],
            ),
          );
        });
  }
}
