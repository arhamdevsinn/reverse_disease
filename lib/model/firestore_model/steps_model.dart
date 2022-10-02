

import 'dart:convert';
import 'dart:developer';

StepsModel stepsModelFromJson(String str) =>
    StepsModel.fromJson(json.decode(str));

String stepsModelToJson(StepsModel data) => json.encode(data.toJson());

class StepsModel {
  StepsModel(
      {this.gender,
      this.primaryGoal,
      this.bodyType,
      this.targetBodyType,
      this.lastTimeHappyness,
      this.activityLevel,
      this.height,
      this.weight,
      this.targetWight,
      this.age,
      this.meditation,
      this.dietFollow,
      this.firstMeal,
      this.lastMeal,
      this.occasion,
      this.eventDate,
      this.email,
      this.name
      });

  String? gender;
  String? primaryGoal;
  String? bodyType;
  String? targetBodyType;
  String? lastTimeHappyness;
  ActivityLevel? activityLevel;
  dynamic height;
  dynamic weight;
  dynamic targetWight;
  dynamic age;
  String? meditation;
  // ActivityLevel? dietFollow;
  DietFollows? dietFollow;
  dynamic firstMeal;
  dynamic lastMeal;
  dynamic occasion;
  dynamic eventDate;
  String? email;
  String? name;

  factory StepsModel.fromJson(json) {
    
    return StepsModel(
        gender: json["gender"],
        primaryGoal: json["primary-goal"],
        bodyType: json["body-type"],
        targetBodyType: json["target-body-type"],
        lastTimeHappyness: json["last-time-happyness"],
        activityLevel: ActivityLevel.fromJson(json["activity-Level"]),
        height: json["height"],
        weight: json["weight"],
        targetWight: json["target-wight"],
        age: json["age"],
        meditation: json["meditation"],
        dietFollow: DietFollows.fromMap(json["diet-follow"]),
        firstMeal: json["first-meal"],
        lastMeal: json["last-meal"],
        occasion: json["occasion"],
        eventDate: json["event-date"],
        email: json["email"],
        name: json["name"]
        );
  }

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "primary-goal": primaryGoal,
        "body-type": bodyType,
        "target-body-type": targetBodyType,
        "last-time-happyness": lastTimeHappyness,
        "activity-Level": activityLevel!.toJson(),
        "height": height,
        "weight": weight,
        "target-wight": targetWight,
        "age": age,
        "meditation": meditation,
        "diet-follow": dietFollow!.toMap(),
        "first-meal": firstMeal,
        "last-meal": lastMeal,
        "occasion": occasion,
        "event-date": eventDate,
        "email": email,
        "name":name
      };
}

class ActivityLevel {
  ActivityLevel({
    this.title,
    this.subtitle,
  });

  dynamic title;
  dynamic subtitle;

  factory ActivityLevel.fromJson(json) {
    // print("this $json");
    log("levellllllllllllllllllllll $json");
    return ActivityLevel(
      title: json["title"],
      subtitle: json["subtitle"],
    );
  }
  toJson() => {
        "title": title == null ? "null" : title,
        "subtitle": subtitle,
      };
}

class DietFollows {
  DietFollows({
    this.title,
    this.subtitle,
  });

  dynamic title;
  dynamic subtitle;

  factory DietFollows.fromMap(json) {
    log("diet $json");
    return DietFollows(
        title: json["title"],
        subtitle: json["subtitle"],
      );
  }
  toMap() => {
        "title": title,
        "subtitle": subtitle,
      };
}

//  {
//      "gender":"",
//      "primary-goal":"",
//      "body-type":"",
//      "target-body-type":"",
//      "last-time-happyness":"",
//      "activity-Level":{
//          "title":"",
//          "subtitle":""
//      },
//      "height":"",
//      "weight":"",
//      "target-wight":"",
//      "age":8,
//      "meditation":"",
//      "diet-follow":{
//          "title":"",
//          "subtitle":""
//      },
//      "first-meal":"",
//      "last-meal":"",
//      "occasion":"",
//      "event-date":""
     
    
     
//  }