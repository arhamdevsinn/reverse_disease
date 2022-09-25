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

class Fasting23HourScreen extends StatefulWidget {
  bool? checkValue;
  Fasting23HourScreen({this.checkValue});

  @override
  State<Fasting23HourScreen> createState() => _Fasting23HourScreenState();
}

class _Fasting23HourScreenState extends State<Fasting23HourScreen> {
  String fastinHourProtocol=  "23:1";
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: 230,
              width: MediaQuery.of(context).size.width,
              color: fastingProtocolColors[4],
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
                        const  Text(
                            "Fasting protocol",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        const  SizedBox(height: 20),
                        const  Text(
                            "OMAD or Extreme TRF - the longest type of TRF",
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
                      "Suitable only for those who are very experienced in fasting and do not have any health concerns. Lengthy fasting periods increase the risk of dehydration and electrolyte imbalances.",
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
                    "Do not eat junk food for your meal. Be sure you get all the necessary nutrients",
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
