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

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

final _formKey = GlobalKey<FormState>();
bool checkValue = false;

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController mailController=TextEditingController();
    TextEditingController passController=TextEditingController();
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
                    hintText: "hiepoonam@gmail.com",
                    prefixIcon: const Icon(
                      Icons.email,
                      color: themeColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller:passController ,
                    errorText: "Please enter your password",
                    hintText: ".......",
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: themeColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    buttonText: "Log out",
                    color: themeColor,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if(FirebaseAuth.instance.currentUser!.email==mailController.text){
                      Auth.signOut(context).then((value)
                      {
                        Get.offAll(() => const LoginScreen());

                      });}
                      else{
                        showSnackbar(context, "email does not exist");
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
