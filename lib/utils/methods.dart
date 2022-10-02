


import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/insight.dart';
import 'globalState.dart';

fetchInsights(context) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("jason/data.json");
    var jsonResult = jsonDecode(data);
    if (jsonResult != null) {
      var model = InsightModel.fromJson(jsonResult);
      GlobalState.insightsList = model;
    }
  }