import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/switchRowWidget.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        backgroundColor: whitecolor,
        elevation: 0.0,
        leading: const BackButton(
          color: blackcolor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              font28Textbold(text: "Reminders"),
              const SizedBox(height: 20),
              font20Textbold(text: "Fasting Reminders"),
              const SizedBox(height: 10),
              SwitchRowWidget(
                text: "1 hour before fast",
                onToggle: false,
              ),
              SwitchRowWidget(
                text: "Fasting start",
                onToggle: false,
              ),
              SwitchRowWidget(
                text: "Goal reached",
                onToggle: false,
              ),
              SwitchRowWidget(
                text: "Last hour",
                onToggle: false,
              ),
              SwitchRowWidget(
                text: "Goal exceeded",
                onToggle: false,
              ),
              SwitchRowWidget(
                text: "Daily insights",
                onToggle: false,
              ),
              SwitchRowWidget(
                text: "Hydration",
                onToggle: false,
              ),
              SwitchRowWidget(
                text: "Weigh - in",
                onToggle: false,
              ),
              SwitchRowWidget(
                text: "Steps",
                onToggle: false,
              ),
              font14Textbold(
                  text: "Get a friendly nudge to achieve your daily step goal")
            ],
          ),
        ),
      ),
    );
  }
}
