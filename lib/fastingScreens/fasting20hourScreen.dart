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

class Fasting20HourScreen extends StatefulWidget {
  bool? checkValue;
  Fasting20HourScreen({this.checkValue});

  @override
  State<Fasting20HourScreen> createState() => _Fasting20HourScreenState();
}

class _Fasting20HourScreenState extends State<Fasting20HourScreen> {
  String fastinHourProtocol= "20:4";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: fastingProtocolColors[3],
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
                            "Prolonged TRF-2 - for experienced users, leverages or boosts the effects of fasting more than the previous types",
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
                      "A more extreme form requiring experience and planning ahead to ensure adequate nutrient consumption. May not be suitable for pregnant women, athletes, or people with a history of eating disorders",
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
                    "Avoid feasting. Make sure you get enough protien and fiber so that you do not slow down your metabolism and digestion. Small portions of baked fish with rice and vegetables, a vegetable omelet, or light vegetable soup with beans and whole-grain toast with avocado are good options",
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
