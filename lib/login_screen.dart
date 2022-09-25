import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_flutter/customBotttomNav.dart';
import 'package:fitness_app_flutter/forget_password.dart';
import 'package:fitness_app_flutter/repository/auth.dart';
import 'package:fitness_app_flutter/sign_up.dart';
import 'package:fitness_app_flutter/utils/snakbar.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:fitness_app_flutter/widgets/myTextField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _formKey = GlobalKey<FormState>();
bool checkValue = false;

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        backgroundColor: whitecolor,
        elevation: 0.0,
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "WELCOME BACK",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: themeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Sign in to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: themeColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: emailController,
                    errorText: "Please enter your email or phone number",
                    hintText: "Email or Phone",
                    prefixIcon: const Icon(
                      Icons.email,
                      color: themeColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    passVlidate: true,
                    controller: passController,
                    errorText: "Please enter your password",
                    hintText: "Password",
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: themeColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    activeColor: themeColor,
                    title: const Text("Remember me"),
                    value: checkValue,
                    onChanged: (bool? newValue) {
                      setState(() {
                        checkValue = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const ForgetPassword());
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    buttonText: "Sign In",
                    color: themeColor,
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      var conectivity =
                          await Connectivity().checkConnectivity();
                      if (_formKey.currentState!.validate()) {
                        if (conectivity == ConnectivityResult.wifi ||
                            conectivity == ConnectivityResult.mobile) {
                          preferences.setBool("authstatus", checkValue);

                          Auth.loginUser(emailController.text,
                                  passController.text, context)
                              .then((value) {
                            if (value != null) {
                              showSnackbar(context, "Login Sucessfully");
                              Future.delayed(const Duration(seconds: 1), (() {
                                Get.off(() => CustomBottomNavigationBar());
                              }));
                            }
                          });
                        } else {
                          showSnackbar(context, "check your interner");
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontSize: 15),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(const SignUp());
                                },
                              text: ' Sign Up',
                              style: const TextStyle(
                                  color: themeColor, fontSize: 15),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
