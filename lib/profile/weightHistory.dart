import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class WeightHistoryScreen extends StatefulWidget {
  const WeightHistoryScreen({Key? key}) : super(key: key);

  @override
  State<WeightHistoryScreen> createState() => _WeightHistoryScreenState();
}

class _WeightHistoryScreenState extends State<WeightHistoryScreen> {
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
            child: font28Textbold(text: "Weight History"),
          ),
          Column(
            children: List.generate(
              2,
              (index) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("images/weight_icon.png", height: 30),
                        const SizedBox(width: 10),
                        font18Textbold(text: "60.0 kg"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        font16Textbold(
                            text: "Fast Easy ",
                            textAlign: TextAlign.end,
                            color: blackcolor.withOpacity(0.3)),
                        font16Textbold(
                            text: "15 Jul",
                            textAlign: TextAlign.end,
                            color: blackcolor.withOpacity(0.3)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
