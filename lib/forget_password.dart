import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_flutter/login_screen.dart';
import 'package:fitness_app_flutter/repository/auth.dart';
import 'package:fitness_app_flutter/utils/snakbar.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:fitness_app_flutter/widgets/myTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'constants/colors.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

final _formKey3 = GlobalKey<FormState>();
bool checkValue = false;

class _ForgetPasswordState extends State<ForgetPassword> {
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
          key: _formKey3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Forget Password",
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
                    errorText: "Please enter your email",
                    hintText: "Email",
                    prefixIcon: const Icon(
                      Icons.email,
                      color: themeColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    buttonText: "Password Reset",
                    color: themeColor,
                    onTap: () {
                      var user = FirebaseAuth.instance.currentUser;
                      if (_formKey3.currentState!.validate()) {
                        if (user!.email == emailController.text) {
                          alertDialog(passController, context);
                           Auth.resetPassword( emailController.text,context).then((value){
                          // Get.to(const LoginScreen());
                          Navigator.pop(context);
                        });
                      }
                        } else {
                          showSnackbar(context,
                              "enter those mail when you use in signUp");
                        }
                       
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future alertDialog(controller, context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Reset Password"),
            content: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: themeColor,
                  hintText: "Reset Password",
                  hintStyle: TextStyle(
                      fontSize: 15, color: blackcolor.withOpacity(0.5))),
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                shape: const StadiumBorder(),
                child: const Text('SUBMIT'),
                onPressed: () {
                  if (controller.text == null || controller.text.isEmpty) {
                    showSnackbar(context, "Enter your password");
                  } else if (controller.text.length < 6) {
                    showSnackbar(
                        context, "Password lenght is less than six character");
                  } else if (controller.text == "123456") {
                    showSnackbar(context, "Password is too easy");
                  } else {
                    var user = FirebaseAuth.instance.currentUser;
                    user!.updatePassword(controller.text).then((value) {
                      showSnackbar(context, "Password updated");
                       Get.off(const LoginScreen());
             
                    });
                  }
                },
              ),
            ],
          );
        });
  }
}
