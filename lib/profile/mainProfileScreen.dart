import 'dart:developer';

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

import '../widgets/customShadowContainer.dart';
import 'LegalMainScreen.dart';

class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({Key? key}) : super(key: key);

  @override
  State<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {

 AuthUserModel? model;
getData()async{
 var data=  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
 data.get().then((value){
model =AuthUserModel.fromJson(value.data() as Map<String,dynamic>);
 });
}

@override
  void initState() {
    super.initState();
    getData();
  }  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        backgroundColor: whitecolor,
        elevation: 0.0,
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const SettingScreen());
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
          ),
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
                const CircleAvatar(
                  backgroundColor: themeColor,
                  maxRadius: 30,
                  child: Icon(
                    Icons.camera_alt,
                    color: whitecolor,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    font16Textbold(text:model?.name.toString()??"no name"),
                    // font16Textbold(
                        // text: "You have lost 2.1 kg", color: themeColor),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            CustomShadowContainer(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                font16Textbold(
                                    text: profileInfoList1Title[index]),
                                const SizedBox(height: 5),
                                font12Textnormal(
                                    text: profileInfoList1Title[index],
                                    color: blackcolor.withOpacity(0.5))
                              ],
                            )),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                font16Textbold(
                                    text: profileInfoList2Title[index]),
                                const SizedBox(height: 5),
                                font12Textnormal(
                                    text: profileInfoList2Subtitle[index],
                                    color: blackcolor.withOpacity(0.5))
                              ],
                            )),
                  )
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
