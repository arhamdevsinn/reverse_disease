import 'dart:developer';

import 'package:fitness_app_flutter/hydrationScreens/hydration_history.dart';
import 'package:fitness_app_flutter/provider/selcected_hours.dart';
import 'package:fitness_app_flutter/repository/sharedPref/shared_pref.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../fastingScreens/fastingPlanScreen.dart';
import '../hydrationScreens/hydrationMainScreen.dart';
import '../insightsScreens/insightScreen1.dart';
import 'chatScreen.dart';

class DashBoardScreen extends StatefulWidget {
  final String? fastingHour;
  const DashBoardScreen({Key? key, this.fastingHour}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
 bool? showStepCount = false;
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _steps = '0';
  int? defaultValve = 0;
  @override
  void initState() {
    super.initState();
    print(showStepCount);
    stepcounterToggle();
    stepActivattorRaguler();
  }

  void stepcounterToggle() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("Stepactive") == null) {
      await prefs.setBool('Stepactive', false);
    }
  }

  void stepActivattor() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('Stepactive', true);
    initState();
  }

  void stepActivattorRaguler() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("Stepactive") == null) {
      prefs.setBool('Stepactive', false);
    } else if (prefs.getBool("Stepactive") == true) {
      initPlatformState();
    } else {
      await prefs.setBool('Stepactive', false);
    }
    setState(() {
      showStepCount = prefs.getBool('Stepactive');
    });
    print(showStepCount);
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      // _steps = 'Step Count not available';
    });
  }

  Future<void> initPlatformState() async {
    if (await Permission.activityRecognition.request().isGranted) {
      // _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
      _stepCountStream =  Pedometer.stepCountStream;
      print(_stepCountStream);
      _stepCountStream.listen(onStepCount).onError(onStepCountError);

      print(_steps);
    } else {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool('Stepactive', false);
      setState(() {
        showStepCount = false;
      });
      initState();
    }
    if (!mounted) return;
  }

  Future<String> data() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('1', double.parse(_steps).toInt());
    print(await prefs.getInt('1'));
    // Timer(Duration(seconds: 1), () {
    //   print("Yeah, this line is printed after 3 seconds");
    //   setState(() {
    //     a = a + 2;
    //   });
    // });
    // await prefs.setInt('2', double.parse(_steps).toInt());

    // print(await prefs.get('1'));
    // print(_steps);
    setState(() {});
    return await prefs.getInt('1').toString();
  }

  @override
  Widget build(BuildContext context) {
    var hoursData = Provider.of<ProviderHourSelectd>(context, listen: false);

    if (kDebugMode) {
      print("jgjg${hoursData.housSelectd}");
    }
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "My fasting plan",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(() => const ChatScreen());
                      },
                      child: const Icon(Icons.chat)),
                ],
              ),
              const SizedBox(height: 20),
              fastingPlanContainer(context, hoursData.housSelectd),
              const SizedBox(height: 20),
              const Text(
                "Today",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              todayFastContainer(context, hoursData.housSelectd),
              const SizedBox(height: 10),
              InkWell(
                  onTap: () => Get.to(const HydrationHistory()),
                  child: hydrationContainer(context)),
              const SizedBox(height: 10),
              !showStepCount!
                  ? Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [kDefaultShadow],
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Reach your step goal",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              const Text("Allow access to enable tracking",
                                  style: TextStyle(fontSize: 14)),
                              const SizedBox(height: 10),
                              CustomButton(
                                  buttonText: "Connect",
                                  onTap: () {
                                     stepActivattor();
                                    setState(() {
                                      showStepCount = true;
                                    });
                                  },
                                  color: themeColor)
                            ]),
                      ),
                    )
                  : Container(
                      height: 95,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [kDefaultShadow],
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "images/stepsicon.png",
                                height: 40,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        "Steps",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children:  [
                                           Text(_steps),
                                      const    SizedBox(width: 90),
                                       const   Text("10 000")
                                        ],
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                        // width: 220.0,
                                        animation: true,
                                        animationDuration: 1000,
                                        lineHeight: 5.0,
                                        // percent: 0.2,
                                        percent:
                                              (double.parse(_steps) / 10000),
                                        linearStrokeCap: LinearStrokeCap.butt,
                                        progressColor: themeColor),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
              const SizedBox(height: 20),
              const Text(
                "Insights for you",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              insightsRow(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
  }

  Row insightsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
          3,
          (index) => InkWell(
                onTap: () {
                  Get.to(() => CustomStoryView());
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: 120,
                  width: 100,
                  decoration: BoxDecoration(
                      color: insightsColor[index],
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    insightsText[index],
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              )),
    );
  }

  Container stepGoalContainer(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [kDefaultShadow],
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Reach your step goal",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text("Allow access to enable tracking",
              style: TextStyle(fontSize: 14)),
          const SizedBox(height: 10),
          CustomButton(
              buttonText: "Connect",
              onTap: () {
                setState(() {});
              },
              color: themeColor)
        ]),
      ),
    );
  }

  FutureBuilder hydrationContainer(BuildContext context) {
    return FutureBuilder<List>(
      future: HydrationPreferences.readHydrationData("hydration") ,
      builder: (context,snapshot) {
        log("${snapshot.data}");
      var  data =snapshot.data;
      num hydrationQuantity=0;
        if(snapshot.hasData){
           for(int i=0;i<data!.length;i++){
          hydrationQuantity = hydrationQuantity+data[i]['quantity'];
           }
        }
        return Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [kDefaultShadow],
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "images/bottle.png",
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Hydration",
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("200 ml"),
                            SizedBox(width: 90),
                            Text("1400 ml")
                          ],
                        ),
                      ),
                      LinearPercentIndicator(
                          width: 220.0,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 5.0,
                          percent:snapshot.data!=null? hydrationQuantity.toDouble()/1400:0.0,
                          linearStrokeCap: LinearStrokeCap.butt,
                          progressColor: themeColor),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => const AddHydrationScreen());
                      },
                      child: const Icon(Icons.add, color: themeColor))
                ],
              ),
            ]),
          ),
        );
      }
    );
  }

  Container todayFastContainer(BuildContext context, hours) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [kDefaultShadow],
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: StreamBuilder<Map<String, dynamic>?>(
            stream: FlutterBackgroundService().on("update"),
            builder: (context, snapshot) {
              var displayTime = snapshot.data?['time'];
            
              return  Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "images/reminder.png",
                      height: 40,
                    ),
                 displayTime!=null?Text(
                      displayTime,
                      style:const
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)):   Text(
                      "Start ${hours.substring(0, 2)}h fast",
                      style:const
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                displayTime!=null?MaterialButton(
                      shape: const StadiumBorder(),
                      color: themeColor,
                      onPressed: () async{
                          final service = FlutterBackgroundService();
                          var isRunning = await service.isRunning();
                          if (isRunning) {
                            service.invoke("stopService");
                          }else{
                            service.startService();
                          }
                      },
                      child: const Text(
                        "Stop Timer",
                        style: TextStyle(
                            color: whitecolor, fontWeight: FontWeight.bold),
                      ),
                    )   : MaterialButton(
                      shape: const StadiumBorder(),
                      color: themeColor,
                      onPressed: () {},
                      child: const Text(
                        "Start",
                        style: TextStyle(
                            color: whitecolor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 15),
                    Image.asset("images/timer.png", height: 30),
                    const SizedBox(width: 10),
                    const Text(
                      "It is time to start your timer now",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                )
              ]);
            }),
      ),
    );
  }

  Container fastingPlanContainer(BuildContext context, hours) {
    return Container(
      height: 170,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [kDefaultShadow],
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(children: [
          InkWell(
            onTap: () {
              // Get.to(() => const ChooseFastingProtocolScreen());
              Get.to(() => const fastingPlanScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "images/timer.png",
                  height: 40,
                ),
                Text(
                  "$hours Prolonged TRF-1",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: blackcolor.withOpacity(0.3),
                  size: 20,
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                7,
                (index) => Column(
                      children: [
                        Image.asset(
                          "images/true.png",
                          height: 30,
                        ),
                        const SizedBox(height: 10),
                        Text(daysName[index])
                      ],
                    )),
          )
        ]),
      ),
    );
  }
}
