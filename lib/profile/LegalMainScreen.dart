import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LegalMainScreen extends StatefulWidget {
  const LegalMainScreen({Key? key}) : super(key: key);

  @override
  State<LegalMainScreen> createState() => _LegalMainScreenState();
}

class _LegalMainScreenState extends State<LegalMainScreen> {
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
            child: font28Textbold(text: "Legal"),
          ),
          Column(
            children: List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        font16Textbold(
                            text: legalOptions[index],
                            textAlign: TextAlign.end,
                            color: blackcolor),
                        const Icon(Icons.arrow_forward_ios, size: 15)
                      ],
                    ),
                    const Divider()
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
