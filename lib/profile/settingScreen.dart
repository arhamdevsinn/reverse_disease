import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/login_screen.dart';
import 'package:fitness_app_flutter/repository/auth.dart';
import 'package:fitness_app_flutter/utils/snakbar.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:fitness_app_flutter/widgets/myTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/loading_dialogue.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

final _formKey = GlobalKey<FormState>();
bool checkValue = false;

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    mailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        backgroundColor: whitecolor,
        elevation: 0.0,
        leading: const BackButton(color: blackcolor),
        title: font16Textbold(text: "Account settings"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: mailController,
                    errorText: "Please enter your email or phone number",
                    hintText: "Enter your email",
                    prefixIcon: const Icon(
                      Icons.email,
                      color: themeColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // MyTextField(
                  //   obscureTextValue: true,
                  //   controller:passController ,
                  //   errorText: "Please enter your password",
                  //   hintText: ".......",
                  //   prefixIcon: const Icon(
                  //     Icons.lock,
                  //     color: themeColor,
                  //   ),
                  // ),
                  const SizedBox(height: 30),
                  CustomButton(
                    buttonText: "Log out",
                    color: themeColor,
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      var conectivity =
                          await Connectivity().checkConnectivity();
                      if (_formKey.currentState!.validate()) {
                        if (conectivity == ConnectivityResult.wifi ||
                            conectivity == ConnectivityResult.mobile) {
                                loading(context: context);
                          if (FirebaseAuth.instance.currentUser!.email ==
                              mailController.text) {

                            Auth.signOut(context).then((value) {
                              if (value == "done") {
                            Navigator.pop(context);
                            FirebaseAuth.instance.signOut();
                            preferences.clear();
                            // await preferences.setBool("authstatus", false);
                                Get.offAll(() => const LoginScreen());
                              }
                            });
                          } else {
                            Navigator.pop(context);
                            showSnackbar(context, "Email Not Matched");
                          }
                        } else {
                          showSnackbar(context, "Check your Internet");
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
