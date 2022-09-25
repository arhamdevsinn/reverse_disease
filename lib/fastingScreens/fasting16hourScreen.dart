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

class Fasting16HourScreen extends StatefulWidget {
  bool? checkValue;
  Fasting16HourScreen({this.checkValue});

  @override
  State<Fasting16HourScreen> createState() => _Fasting16HourScreenState();
}

class _Fasting16HourScreenState extends State<Fasting16HourScreen> {
  String fastinHourProtocol="16:8";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              color: fastingProtocolColors[1],
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
                            style:const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        const  SizedBox(height: 10),
                         const Text(
                            "Fasting protocol",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                         const SizedBox(height: 20),
                         const Text(
                            "Classic TRF - the most popular type that helps get the benefits of fasting without excessive hunger or eating limits",
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
                      "Appropriate for most people, as most find it easy to stick to this time-restricted eating plan over the long term.",
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
                    "Eat every 3-4 hours daily the eating window. It is important to get beneficial nutrients, so focus on whole foods: lean protien sources, whole grains, fruits, and vegetables. Control your portions so that you do not overeat, especially when you break the fast",
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
