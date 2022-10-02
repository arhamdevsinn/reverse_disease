import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app_flutter/repository/auth.dart';
import 'package:fitness_app_flutter/repository/fire_store.dart';
import 'package:fitness_app_flutter/repository/steps_storage.dart';
import 'package:fitness_app_flutter/utils/loading_dialogue.dart';
import 'package:fitness_app_flutter/utils/snakbar.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:fitness_app_flutter/widgets/myTextField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'constants/colors.dart';
import 'fastingScreens/fastingProtocolScreen.dart';
import 'login_screen.dart';
import 'model/auth-model/auth_user_model.dart';

class SignUp extends StatefulWidget {
  var gender;
  var primaryGoal;
  var bodyType;
  var targetBodyType;
  var lastTimeHappyness;
  Map? activityLevel;
  var height;
  var weight;
  var targetWeight;
  var age;
  var meditation;
  Map? dietFollow;
  var firstMeal;
  var lastMeal;
  var occasion;
  var eventDate;
  SignUp(
      {Key? key,
      this.gender,
      this.bodyType,
      this.primaryGoal,
      this.targetBodyType,
      this.lastTimeHappyness,
      this.activityLevel,
      this.height,
      this.weight,
      this.targetWeight,
      this.age,
      this.meditation,
      this.dietFollow,
      this.firstMeal,
      this.lastMeal,
      this.occasion,
      this.eventDate})
      : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

final _formKey2 = GlobalKey<FormState>();
bool checkValue = false;
bool? visibility = true;

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confermPassController = TextEditingController();
  StepsStorage stepsStorage = StepsStorage();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confermPassController.dispose();
  }

  FireStoreData? fireStoreData = FireStoreData();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        backgroundColor: whitecolor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Center(
                      child: Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: themeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    MyTextField(
                      controller: nameController,
                      errorText: "Please enter your name",
                      hintText: "Name",
                      prefixIcon: const Icon(
                        Icons.person,
                        color: themeColor,
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
                      obscureTextValue: true,
                      controller: passController,
                      errorText: "Please enter your password",
                      hintText: "Password",
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: themeColor,
                      ),
                    ),
                    // const SizedBox(height: 10),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: confermPassController,
                      obscureText: visibility!,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (visibility == true) {
                                setState(() {
                                  visibility = false;
                                });
                              } else {
                                visibility = true;
                                setState(() {});
                              }
                            },
                            child: visibility != true
                                ? const Icon(
                                    Icons.visibility,
                                    color: themeColor,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: themeColor,
                                  ),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: themeColor,
                          ),
                          prefixIconColor: themeColor,
                          hintText: "Conferm Password",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: blackcolor.withOpacity(0.5))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Confer your password";
                        } else if (confermPassController.text !=
                            passController.text) {
                          return "Passwor is not matched";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 30),
                     CustomButton(
                        buttonText: "Sign Up",
                        color: themeColor,
                        onTap: () async {
                          var conectivity =
                              await Connectivity().checkConnectivity();
                          if (_formKey2.currentState!.validate()) {
                            if (conectivity == ConnectivityResult.wifi ||
                                conectivity == ConnectivityResult.mobile) {
                              var data = {
                                "gender": widget.gender,
                                "primary-goal": widget.primaryGoal,
                                "body-type": widget.bodyType,
                                "target-body-type": widget.targetBodyType,
                                "last-time-happyness": widget.lastTimeHappyness,
                                "activity-Level": {
                                  "title": widget.activityLevel!["title"],
                                  "subtitle": widget.activityLevel!["subtitle"]
                                },
                                "height": widget.height,
                                "weight": widget.weight,
                                "target-wight": widget.targetWeight,
                                "age": widget.age,
                                "meditation": widget.meditation,
                                // "diet-follow":widget.dietFollow,
                                "diet-follow": {
                                  "title": widget.dietFollow!["title"],
                                  "subtitle": widget.dietFollow!["subtitle"],
                                },
                                "first-meal": widget.firstMeal,
                                "last-meal": widget.lastMeal,
                                "occasion": widget.occasion,
                                "event-date": widget.eventDate,
                                "email": emailController.text,
                                "name": nameController.text
                              };

                              loading(context: context);
                              // ignore: use_build_context_synchronously
                              Auth.crateUser(emailController.text,
                                      passController.text, context)
                                  .then((value) async {
                                if (value != null) {
                                  AuthUserModel model =
                                      AuthUserModel.fromJson(data);
                                  stepsStorage.enterData(data).then((value) {
                                 
                                      showSnackbar(context,
                                          "Created account scucessfully");
                                      Get.to(() => ChooseFastingProtocolScreen(
                                            checkBool: false,
                                          ));
                                    
                                  });
                                  
                                }
                              });
                            } else {
                              showSnackbar(context, "Check your Internet");
                            }
                          }
                        },
                      ),
                    
                    const SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Bach to the Login Screen ',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 15),
                            children: <TextSpan>[
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(const LoginScreen());
                                    // Navigator.pop(context);
                                  },
                                text: ' Log In',
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
      ),
    );
  }
}
