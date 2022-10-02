import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../customBotttomNav.dart';

class Fasting12to23HourScreen extends StatefulWidget {
  bool? checkValue;
  Fasting12to23HourScreen({this.checkValue});

  @override
  State<Fasting12to23HourScreen> createState() =>
      _Fasting12to23HourScreenState();
}

class _Fasting12to23HourScreenState extends State<Fasting12to23HourScreen> {
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  List hours = [
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23"
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: fastingProtocolColors[5],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Fasting protocol",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                children: List.generate(
                    hours.length,
                    (index) => InkWell(
                          onTap: () => _onSelected(index),
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: _selectedIndex != null &&
                                        _selectedIndex == index
                                    ? fastingProtocolColors[5]
                                    : whitecolor,
                                borderRadius: BorderRadius.circular(10)),
                            height: 50,
                            width: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    hours[index],
                                    style: TextStyle(
                                        color: _selectedIndex != null &&
                                                _selectedIndex == index
                                            ? whitecolor
                                            : Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: widget.checkValue!
                    ? CustomButton(
                        buttonText: "Choose this protocol",
                        onTap: () {
                          Get.to(() => CustomBottomNavigationBar());
                        },
                        color: themeColor)
                    : CustomButton(
                        buttonText: "Save",
                        onTap: () {
                          Get.offAll(() => CustomBottomNavigationBar());
                        },
                        color: themeColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
