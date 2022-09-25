import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../customBotttomNav.dart';
import '../provider/selcected_hours.dart';

class Fasting18HourScreen extends StatefulWidget {
  bool? checkValue;
  Fasting18HourScreen({this.checkValue});

  @override
  State<Fasting18HourScreen> createState() => _Fasting18HourScreenState();
}

class _Fasting18HourScreenState extends State<Fasting18HourScreen> {
  String fastinHourProtocol= "18:6";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: fastingProtocolColors[2],
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackButton(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                           fastinHourProtocol,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Fasting protocol",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Prolonged TRF - the next level after the classic type that boosts autophagy.",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(10),
              height: 190,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 208, 245, 245)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Poonam Dua",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2),
                            Text("Registered Dietitian")
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Shorter eating windows maybe more difficult to follow. You can include two meals and a snack, such as choosing to skip breakfast and having an early dinner or a late lunch",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Food recommendations",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Break your fast with a small portion of easy-to-digest food: smoothie, dried fruits, light soups, cooked vegetables, fermented dairy ( yogurt, kefir). After, eat with a focus on whole foods",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: widget.checkValue!
                  ? CustomButton(
                      buttonText: "Choose this protocol",
                      onTap: () {
                           Provider.of<ProviderHourSelectd>(context,listen: false).selectedProtocl(fastinHourProtocol);
                        Get.to(() => CustomBottomNavigationBar());
                      },
                      color: themeColor)
                  : CustomButton(
                      buttonText: "Save",
                      onTap: () {
                           Provider.of<ProviderHourSelectd>(context,listen: false).selectedProtocl(fastinHourProtocol);
                        Get.offAll(() => CustomBottomNavigationBar());
                      },
                      color: themeColor),
            )
          ],
        )),
      ),
    );
  }
}
