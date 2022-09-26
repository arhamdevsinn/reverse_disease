import 'dart:developer';

import 'package:fitness_app_flutter/model/hydration-model.dart/hydration_model.dart';
import 'package:fitness_app_flutter/repository/sharedPref/shared_pref.dart';
import 'package:flutter/material.dart';

import '../../utils/snakbar.dart';

class HydrationLogic {
  static Future addHydrationLogic(HydrationModel data, name, context) async {
    dynamic add = 0;
    bool flag = true;
    var getData = await HydrationPreferences.readHydrationData(name);
    log("${getData}");
    if (getData.isNotEmpty) {
      for (int i = 0; i < getData.length; i++) {
        if (
          // (getData[i]["liquid"] == data.liquid) &&
            (getData[i]["date"] == data.date)) {
          add = getData[i]["quantity"] + data.quantity;
          getData[i]["quantity"] = add;
          // showSnackbar(context, "Data added successfully");
          await HydrationPreferences.saveHydrationData(getData, name);
          HydrationLogic2.addHydrationLogic2(data, "hydration2",context);
          flag = false;
        }
      }
      if (flag == true) {
        getData.add(data);
        await HydrationPreferences.saveHydrationData(getData, name);
        HydrationLogic2.addHydrationLogic2(data, "hydration2",context);
        // showSnackbar(context, "Data added successfully");
      }
    } else {
      List<HydrationModel> list = [];

      list.add(data);
      await HydrationPreferences.saveHydrationData(list, name);
      HydrationLogic2.addHydrationLogic2(data, "hydration2",context);
      // showSnackbar(context, "Data addes succesfully");
    }
    Navigator.pop(context);
  }
}
/////////////////////////////////////
////////////////////////////////////
////////////////////////////////////
////////////////////////////////////

class HydrationLogic2 {
  static Future addHydrationLogic2(HydrationModel data, name, context) async {

    var getData = await HydrationPreferences.readHydrationData(name);
    log(" 2  is ${getData}");
    if (getData.isNotEmpty) {
      getData.add(data);
      await HydrationPreferences.saveHydrationData(getData, name);
    } else {
      List<HydrationModel> list = [];

      list.add(data);
      await HydrationPreferences.saveHydrationData(list, name);
    }
  }
}
