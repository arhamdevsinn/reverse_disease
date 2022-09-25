import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:flutter/material.dart';


class HydrationHistoryScreen extends StatefulWidget {
  const HydrationHistoryScreen({Key? key}) : super(key: key);

  @override
  State<HydrationHistoryScreen> createState() => _HydrationHistoryScreenState();
}

class _HydrationHistoryScreenState extends State<HydrationHistoryScreen> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: font28Textbold(text: "Hydration History"),
          ),
          Column(
            children: List.generate(
              2,
              (index) => Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 80,
                color: fastingProtocolColors[0],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      font18Textbold(text: "200 ml"),
                      font16Textbold(
                          text: "13 Aug 2022 ",
                          textAlign: TextAlign.end,
                          color: blackcolor.withOpacity(0.3))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
