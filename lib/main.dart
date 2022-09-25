import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app_flutter/customBotttomNav.dart';
import 'package:fitness_app_flutter/provider/selcected_hours.dart';
import 'package:fitness_app_flutter/role_selection_screen.dart';
import 'package:fitness_app_flutter/timerScreens/timerMainScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var timeStatue = preferences.getBool("timerstate");
 timeStatue==true? await initializeService():null;

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProviderHourSelectd(),
        builder: (context, child) {
          return GetMaterialApp(
            theme: ThemeData(fontFamily: "Campton"),
            debugShowCheckedModeBanner: false,
            // home: const SplashScreen(),
            home: CustomBottomNavigationBar(),
          );
        });
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var boolValue;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      preferences = await SharedPreferences.getInstance();
      boolValue = preferences?.getBool("authstatus");

      boolValue != true
          ? Get.offAll(() => const RoleSelectionScreen())
          : Get.to(CustomBottomNavigationBar());
      ;
    });
  }

  SharedPreferences? preferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whitecolor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  "images/app_logo.jpeg",
                  height: 200,
                )),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }
}
