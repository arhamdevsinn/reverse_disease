// import 'dart:html';

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/model/auth-model/auth_user_model.dart';
import 'package:fitness_app_flutter/model/firestore_model/steps_model.dart';
import 'package:fitness_app_flutter/model/personalDetails.dart';
import 'package:fitness_app_flutter/utils/snakbar.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  PersonalDetailsModel personalDetails = PersonalDetailsModel();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  

  @override
  void initState() {
    super.initState();
  }
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
        title: font18Textbold(text: "Personal Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: FutureBuilder(
   
              future: users
                  .doc("initial-steps:${FirebaseAuth.instance.currentUser!.email}")
                  .get()
                  ,
              builder: (context,AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data != null && snapshot.data.data() != null) {
                  DocumentSnapshot data = snapshot.data;
                  print("${data.data()} DATA HERE");
                StepsModel model = StepsModel.fromJson(data.data());
                
                
                List list = [
                  {
                    "title": "Name",
                    "subtitle": model.name??"",
                  },
                {
                 "title": "Gender",
                    "subtitle": model.gender,
                },
                {
                 "title": "Age",
                    "subtitle": model.age,
                },
                 {
                 "title": "Height",
                    "subtitle": model.height,
                },
                 {
                 "title": "Actual Weight",
                    "subtitle": model.weight,
                },
                 {
                 "title": "Target Weight",
                    "subtitle": model.targetWight,
                    
                },
                 {
                 "title": "Goal",
                    "subtitle": model.primaryGoal,
                },
                 {
                 "title": "Activity Level",
                    "subtitle": model.activityLevel!.toJson()['title'],
                    // "subtitle":data.get("activity-Level")['title'],
                },
                 {
                 "title": "Diet",
                    "subtitle": model.dietFollow!.title,
                },
                ];
                
  
                if(FirebaseAuth.instance.currentUser!.email==model.email){

                return Column(
                  children: [
                    Column(
                      children: List.generate(
                          // personalDetails.personalDetailsList.length,
                          list.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                  
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        font16Textnormal(
                                            // text: personalDetails
                                            //         .personalDetailsList[index]
                                            //     ["title"]),
                                            text:list[index]["title"].toString(),),
                                        font16Textbold(
                                            // text: personalDetails
                                            //         .personalDetailsList[index]
                                            //     ["subTitle"])
                                            text: list[index]["subtitle"].toString()
                                            
                                            ,)
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              )),
                    ),
                    // CustomButton(
                    //     buttonText: "Download personal data",
                    //     onTap: () {
                         
                    //     },
                    //     color: fastingProtocolColors[4]),
                    const SizedBox(height: 10),
                    // CustomButton(
                    //     buttonText: "Delete personal data",
                    //     onTap: () {
                    //       users;
                    //      users.doc("initial-steps").delete().then((value){
                    //       showSnackbar(context, "Deleted successfully");
                    //      });
                    //      setState(() {
                           
                    //      });
                    //     },
                    //     color: themeColor),
                    // const SizedBox(height: 20),
                  ],
                );}
               else{
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child:const  Center(child: CircularProgressIndicator()),
                );

               } 
              }
                
                  return SizedBox(
                    height:MediaQuery.of(context).size.height,
                    child:const Center(child: Text("Loading Info....")));
                
              }
                ),
        ),
      ),
    );
  }
}
