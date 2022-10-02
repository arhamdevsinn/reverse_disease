import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/model/auth-model/auth_user_model.dart';
import 'package:fitness_app_flutter/profile/settingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/firestore_model/steps_model.dart';
import '../repository/fastingPref/fasting_history_pref.dart';
import '../widgets/customShadowContainer.dart';
import 'LegalMainScreen.dart';

class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({Key? key}) : super(key: key);

  @override
  State<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  AuthUserModel? model;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  void initState() {
    super.initState();
  }

  File? _image;
  String? myImagePath;

  Future getImage(ImageSource sorce) async {
    try {
      final image = await ImagePicker().pickImage(source: sorce);
      if (image == null) return;

      final imagePermanent = await saveFilePermanently(image.path);

      setState(() {
        // ignore: unnecessary_this
        this._image = imagePermanent;
      });
    } catch (e) {}
  }

  Future<File> saveFilePermanently(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File("${directory.path}/$name");
    setState(() {
      prefs.setString("profilImage", image.path);
    });

    return File(imagePath).copy(image.path);
  }

  loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    myImagePath = prefs.getString("profilImage");
    return myImagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        backgroundColor: whitecolor,
        elevation: 0.0,
        actions: [
          InkWell(
              onLongPress: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.remove("profilImage");
              },
              onTap: () {
                Get.to(() => const SettingScreen());
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    getImage(ImageSource.camera);
                  },
                  child: FutureBuilder(
                      future: loadImage(),
                      builder: (context, AsyncSnapshot snapshot) {
                        log(snapshot.data.toString());
                        if (snapshot.hasData && snapshot.data != null) {
                          myImagePath = snapshot.data.toString();
                          return CircleAvatar(
                            backgroundColor: themeColor,
                            maxRadius: 30,
                            backgroundImage:
                                FileImage(File(snapshot.data.toString())),
                          );
                        } else {
                          return const CircleAvatar(
                            backgroundColor: themeColor,
                            radius: 30,
                            child: Icon(
                              Icons.camera_alt,
                              color: whitecolor,
                            ),
                          );
                        }
                      }),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: FutureBuilder(
                      future: users
                          .doc(
                              "initial-steps:${FirebaseAuth.instance.currentUser!.email}")
                          .get(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data != null &&
                            snapshot.data.data() != null) {
                          DocumentSnapshot data =
                              snapshot.data as DocumentSnapshot;
                          model = AuthUserModel.fromJson(
                              data.data() as Map<String, dynamic>);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              font16Textbold(text: model!.name.toString()),
                            ],
                          );
                        } else {
                          return const SizedBox(
                              child: Text("Loading Info...."));
                        }
                      }),
                )
              ],
            ),
            const SizedBox(height: 20),
            CustomShadowContainer(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FutureBuilder<List>(
                      future: FastingHistoryPref.readFastingHistory(
                          "fastingHistory"),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          int totalFast = 0;
                          int totalHour=0;
                          var longestFast = 0;

                          for (int i = 0; i < snapshot.data!.length; i++) {
                            totalFast = i + 1;
                            totalHour= totalHour +int.parse(snapshot.data![i]["fastingDuration"]
                                      .substring(0, 2));
                            for (int j = i + 1;
                                j < snapshot.data!.length;
                                j++) {
                              if (int.parse(snapshot.data![i]["fastingDuration"]
                                      .substring(0, 2)) <
                                  int.parse(snapshot.data![j]["fastingDuration"]
                                      .substring(0, 2))) {
                                longestFast = int.parse(snapshot.data![i]
                                        ["fastingDuration"]
                                    .substring(0, 2));
                              }
                            }
                          }
                          List listData=[
                            totalFast,
                            totalHour.toString().padRight(2," h"),
                            longestFast.toString().padRight(2," h"),
                          ];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                                3,
                                (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        font16Textbold(
                                            // text: profileInfoList1Title[index],
                                            text: listData[index].toString(),
                                            ),
                                        const SizedBox(height: 5),
                                        font12Textnormal(
                                            text:
                                                profileInfoList1Subtitle[index],
                                            color: blackcolor.withOpacity(0.5))
                                      ],
                                    )),
                          );
                        } else {
                          return const SizedBox(
                              child: Text("Loading Info...."));
                        }
                      }),
                  const SizedBox(height: 20),
                  FutureBuilder(
                      future: users
                          .doc(
                              "initial-steps:${FirebaseAuth.instance.currentUser!.email}")
                          .get(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data != null &&
                            snapshot.data.data() != null) {
                          DocumentSnapshot data = snapshot.data;
                          StepsModel model = StepsModel.fromJson(data.data());
                          List weight = [
                            model.weight,
                            '0'.padRight(2,' kg'),
                            model.targetWight,
                          ];

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                                // 3,
                                weight.length,
                                (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        font16Textbold(
                                          // text: profileInfoList2Title[index]),
                                          text: weight[index].toString(),
                                        ),
                                        const SizedBox(height: 5),
                                        font12Textnormal(
                                            text:
                                                profileInfoList2Subtitle[index],
                                            color: blackcolor.withOpacity(0.5))
                                      ],
                                    )),
                          );
                        } else {
                          return const SizedBox(
                              child: Text("Loading Info...."));
                        }
                      })
                ],
              ),
            ),
            const SizedBox(height: 15),
            CustomShadowContainer(
              widget: Column(
                children: List.generate(
                    5,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            profileCategories[index]
                                                ["navigate"]),
                                  );
                                },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            profileCategories[index]["icon"],
                                            height: 20,
                                          ),
                                          const SizedBox(width: 10),
                                          font16Textnormal(
                                              text: profileCategories[index]
                                                  ["title"])
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: blackcolor.withOpacity(0.5),
                                      )
                                    ]),
                              ),
                              const Divider()
                            ],
                          ),
                        )),
              ),
            ),
            const SizedBox(height: 15),
            CustomShadowContainer(
              widget: Column(
                children: List.generate(
                    2,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              Get.to(() => const LegalMainScreen());
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          profileCategories2[index]["icon"],
                                          height: 20,
                                        ),
                                        const SizedBox(width: 10),
                                        font18Textmedium(
                                            text: profileCategories2[index]
                                                ["title"])
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                      color: blackcolor.withOpacity(0.5),
                                    )
                                  ],
                                ),
                                const Divider()
                              ],
                            ),
                          ),
                        )),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      )),
    );
  }
}
