import 'package:fitness_app_flutter/questionsScreen/enter_emailscreen.dart';
import 'package:flutter/material.dart';
import '../constants/strings.dart';
import '../constants/textHelper.dart';
import 'fasting12-23hourScreen.dart';
import 'fasting14hourScreen.dart';
import 'fasting16hourScreen.dart';
import 'fasting18hourScreen.dart';
import 'fasting20hourScreen.dart';
import 'fasting23hourScreen.dart';

class ChooseFastingProtocolScreen extends StatefulWidget {
  bool? checkBool;
  ChooseFastingProtocolScreen({this.checkBool});
  @override
  State<ChooseFastingProtocolScreen> createState() =>
      _ChooseFastingProtocolScreenState();
}

class _ChooseFastingProtocolScreenState
    extends State<ChooseFastingProtocolScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.checkBool);
  }

  @override
  Widget build(BuildContext context) {
    List fastingProtocolScreens = [
      Fasting14HourScreen(
        checkValue: widget.checkBool,
  
      ),
      Fasting16HourScreen(
        checkValue: widget.checkBool,
      ),
      Fasting18HourScreen(
        checkValue: widget.checkBool,
      ),
      Fasting20HourScreen(
        checkValue: widget.checkBool,
      ),
      Fasting23HourScreen(
        checkValue: widget.checkBool,
      ),
      Fasting12to23HourScreen(
        checkValue: widget.checkBool,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Fasting protocols",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 1.4),
                ),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                fastingProtocolScreens[index]),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: fastingProtocolColors[index],
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  fastingProtocolHours[index],
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Image.asset(
                                    "images/timer.png",
                                    height: 50,
                                  ),
                                )
                              ],
                            ),
                            const Text(
                              "hour",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(fastingProtocolDescription[index]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                font14Textbold(text: "Read more"),
                                // ignore: prefer_const_constructors
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.music_note),
                    title: const Text('Music'),
                    onTap: () => {}),
                ListTile(
                  leading: const Icon(Icons.videocam),
                  title: const Text('Video'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }
}
