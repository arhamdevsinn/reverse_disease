import 'package:fitness_app_flutter/hydrationScreens/hydration_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profile/fastingDetails.dart';
import '../profile/hydrationHistory.dart';
import '../profile/personalDetails.dart';
import '../profile/reminderScreen.dart';
import '../profile/weightHistory.dart';

List daysName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
List insightsColor = [
  const Color(0xffffcf66),
  const Color(0xffff7fa5),
  const Color(0xff60e1c2)
];

List allInsightsColor = [
  const Color(0xffACDDDE),
  const Color(0xffffcf66),
  const Color(0xffff7fa5),
  const Color(0xff60e1c2),
  const Color(0xffFFE7C7),
  const Color(0xffED9FE3),
  const Color(0xffF5F17A),
  const Color(0xff4DC5E3)
];
List insightsText = [
  "How Much Water Do You Need?",
  "Day 2:\n Learn About the",
  "7 Benefits of\n Intermittent"
];
List fastingProtocolColors = [
  const Color.fromARGB(255, 226, 255, 146),
  const Color.fromARGB(255, 255, 184, 223),
  const Color.fromARGB(255, 158, 250, 229),
  const Color.fromARGB(255, 158, 209, 243),
  const Color.fromARGB(255, 247, 219, 142),
  const Color.fromARGB(255, 202, 170, 255),
];
List fastingProtocolHours = [
  "14",
  "16",
  "18",
  "20",
  "23",
  "12-23",
];
List fastingProtocolDescription = [
  "Jump into fasting with this easy protocol",
  "Try the most wide-spread take on fasting",
  "Level up your fasting routine",
  "Challenge yourself with this tough protocol",
  "Check if you are tough enough to survive it",
  "For the most hardcore fasters",
];

List abcOfFastingInsights = [
  "Is Intermittent Fasting Actually Good",
  "Fasting Reboots Your Immune",
  "How Does Fasting Work?",
  "7 Benefits of Intermittent Fasting",
  "Are Fasting Diets Safe and Effective?",
  "Why Do Experts Say Fasting is",
  "5 Tips for Doing Fasting in a Healthy",
  "Intermittent Fasting Checklist",
  "How Much you are Risking Trying",
  "Who Needs to Be Careful with Fasting",
  "Right Way to Break Your Fast",
  "What is an Anabolic Fasting Zone?",
  "What is Catabolic Fasting Zone?",
  "Insulin Drops: What Happens to Our Body",
  "How to Increase Autophagy",
  "Autophagy: What Is It and How Doest Tt",
];
List abcFastingColors = [
  const Color.fromARGB(255, 226, 255, 146),
  const Color.fromARGB(255, 255, 184, 223),
  const Color.fromARGB(255, 158, 250, 229),
  const Color.fromARGB(255, 158, 209, 243),
  const Color.fromARGB(255, 247, 219, 142),
  const Color.fromARGB(255, 202, 170, 255),
  const Color.fromARGB(255, 226, 255, 146),
  const Color.fromARGB(255, 255, 184, 223),
  const Color.fromARGB(255, 158, 250, 229),
  const Color.fromARGB(255, 158, 209, 243),
  const Color.fromARGB(255, 247, 219, 142),
  const Color.fromARGB(255, 202, 170, 255),
  const Color.fromARGB(255, 226, 255, 146),
  const Color.fromARGB(255, 255, 184, 223),
  const Color.fromARGB(255, 158, 250, 229),
  const Color.fromARGB(255, 158, 209, 243),
];

List profileInfoList1Title = [
  "2",
  "0 h",
  "0 h",
];
List profileInfoList1Subtitle = [
  "total fasts",
  "total hours",
  "longest fast",
];
List profileInfoList2Title = [
  "60 kg",
  "57.9 kg",
  "46 kg",
];
List profileInfoList2Subtitle = [
  "start weight",
  "current weight",
  "goal weight"
];

List<Map> profileCategories = [
  {
    "icon": "images/personal_icon.png",
    "title": "Personal details",
    "navigate": const PersonalDetails()
  },
  {
    "icon": "images/fastinghis_icon.png",
    "title": "Fasting history",
    "navigate": const FastingDetails()
  },
  {
    "icon": "images/hydration_icon.png",
    "title": "Hydration history",
    // "navigate": const HydrationHistoryScreen()
    "navigate":const HydrationHistory()
  },
  {
    "icon": "images/weight_icon.png",
    "title": "Weight history",
    "navigate": const WeightHistoryScreen()
  },
  {
    "icon": "images/reminder_icon.png",
    "title": "Reminders",
    "navigate": const ReminderScreen()
  }
];
List<Map> profileCategories2 = [
  {"icon": "images/legal_icon.png", "title": "Legal"},
  {"icon": "images/contactus_icon.png", "title": "Contact us"},
];

List legalOptions = ["Terms of Use", "Privacy Policy", "Subscription Terms"];

List statisticsTitle = ["2", "0 h", " 2.1 kg"];
List statisticssubTitle = ["total fasts", "longest fast", "weight change"];

String fastingTip = "Keep hydrated during the fast\n"
    "Feel free to have plain tea"
    "and coffee while fasting"
    "(without sugar)\n"
    "Low-intensity physical"
    "activities (walking, light yoga,"
    "pilates)\n"
    "Mid- and high-intensity"
    "Dashboard"
    "physical activities (running,\n"
    "resistance training)";
