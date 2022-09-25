import 'package:fitness_app_flutter/model/firestore_model/steps_model.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/colors.dart';
import 'login_screen.dart';
import 'questionsScreen/genderSelection.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "images/logo.png",
                height: 150,
              ),
            ),
            const SizedBox(height: 30),
            const Center(
              // ignore: unnecessary_const
              child: const Text(
                "REVERSE YOUR DISEASES WITH FOOD",
                style: TextStyle(
                  fontSize: 20,
                  color: themeColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "By continuting you accept our Privacy Policy.\n Terms of Use & Subscription Terms",
                style: TextStyle(
                  fontSize: 12,
                  color: themeColor,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 50),
            CustomButton(
                color: themeColor,
                buttonText: "Get Started",
                onTap: () {
                  // ignore: prefer_const_constructors
                  Get.to(() => GenderSelection());
                }),
            const SizedBox(height: 20),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: whitecolor,
              minWidth: MediaQuery.of(context).size.width,
              height: 55,
              onPressed: () {
                
                Get.to(() => const LoginScreen());
              },
              child: const Text(
                "Already have an account",
                style: TextStyle(
                    fontSize: 16,
                    color: themeColor,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
