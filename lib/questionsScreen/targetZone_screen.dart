import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:fitness_app_flutter/questionsScreen/bodyTypeBoyScreen.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/primaryGoal.dart';

class TargetZoneScreen extends StatefulWidget {
  var gender;
  var primaryGoal;
   TargetZoneScreen({Key? key,this.gender,this.primaryGoal}) : super(key: key);

  @override
  State<TargetZoneScreen> createState() => _TargetZoneScreenState();
}

class _TargetZoneScreenState extends State<TargetZoneScreen> {
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  PrimaryGoalModel primaryGoalModel = PrimaryGoalModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 4 of 17",
            style: appBarTextStyle,
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 30),
            const Text("What is your target zones?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    color: themeColor,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                  color: themeColor,
                  buttonText: "Continue",
                  onTap: () {
                    print(widget.primaryGoal);
                     print(widget.gender);
                    Get.to(() =>  BoyBodyTypeScreen(gender: widget.gender,primaryGoal: widget.primaryGoal,));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
