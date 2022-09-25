import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'currentWeightScreen.dart';

class HowTallScreen extends StatefulWidget {
  var gender;
  var primaryGoal;
  var bodyType;
  var targetBodyType;
  var lastTimeHappyness;
  Map? activityLevel;
  HowTallScreen(
      {Key? key,
      this.gender,
      this.bodyType,
      this.primaryGoal,
      this.targetBodyType,
      this.lastTimeHappyness,
      this.activityLevel})
      : super(key: key);

  @override
  State<HowTallScreen> createState() => _HowTallScreenState();
}

class _HowTallScreenState extends State<HowTallScreen> {
  var _tabTextIndexSelected = 1;
  final _listTextTabToggle = [
    "ft",
    "cm",
  ];
  TextEditingController tallController = TextEditingController();
  // final TextEditingController _textController = TextEditingController();
  final String _cm = " cm";
  final String _in = " ft";
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    tallController.dispose();
    super.dispose();
  }
var data;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            "Step 9 of 17",
            style: appBarTextStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    SizedBox(height: 30),
                    Center(
                      child: Text("How tall are you?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              color: themeColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                TextFormField(
                  controller: tallController,
                  validator: (value) {
                    data = value;
                    if (_tabTextIndexSelected == 1) {
                      if (int.parse(value!) <= 39) {
                        return "Please enter a number between 40 and 250";
                      } else if (int.parse(value) >= 251) {
                        return "Please enter a number between 40 and 250";
                      } else if (value == null || value.isEmpty) {
                        return "errorText";
                      }
                    }
                    if (_tabTextIndexSelected == 1) {
                      value!.endsWith(_cm)
                          ? tallController.text = value
                          : tallController.text = value + _cm;
                      tallController.selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: tallController.text.length - _cm.length));
                    } else if (_tabTextIndexSelected == 0) {
                      if (int.parse(value!) <= 1) {
                        return "Please enter a number between 1 and 8";
                      } else if (int.parse(value) >= 9) {
                        return "Please enter a number between 1 and 8";
                      }
                    }
                    if (_tabTextIndexSelected == 0) {
                      value!.endsWith(_in)
                          ? tallController.text = value
                          : tallController.text = value + _in;
                      tallController.selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: tallController.text.length - _in.length));
                    }
                    return null;
                  },
                  decoration:const InputDecoration(),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style:const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                FlutterToggleTab(
                  // width in percent
                  width: 30,
                  borderRadius: 30,
                  height: 30,
                  selectedIndex: _tabTextIndexSelected,
                  selectedBackgroundColors: [themeColor],
                  selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  unSelectedTextStyle: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  labels: _listTextTabToggle,
                  selectedLabelIndex: (index) {
                    setState(() {
                      _tabTextIndexSelected = index;
                    });
                  },
                  isScroll: false,
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    ValueListenableBuilder<TextEditingValue>(
                        valueListenable: tallController,
                        builder: (context, value, child) {
                          return MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: themeColor,
                            minWidth: MediaQuery.of(context).size.width,
                            height: 55,
                            onPressed: value.text.isNotEmpty
                                ? () {
                                    print(widget.activityLevel);
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.of(context).push(MaterialPageRoute(builder:(context) => CurrentWeightScreen(
                                            gender: widget.gender,
                                            primaryGoal: widget.primaryGoal,
                                            bodyType: widget.bodyType,
                                            targetBodyType:
                                                widget.targetBodyType,
                                            lastTimeHappyness:
                                                widget.lastTimeHappyness,
                                            activityLevel: widget.activityLevel,
                                            height:tallController.text.toString(),
                                          )));
                                    }
                                  }
                                : null,
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: value.text.isNotEmpty
                                      ? whitecolor
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }),
                    const SizedBox(height: 30),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
