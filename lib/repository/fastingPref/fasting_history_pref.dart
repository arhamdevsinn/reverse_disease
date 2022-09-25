import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FastingHistoryPref {
  static Future<dynamic> saveFastingHistory(data,name) async {
    
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString("$name",jsonEncode(data) );
  }

  static Future<List> readFastingHistory(name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = preferences.getString("$name");
    if (data != null) {
      print("Dats is ${jsonDecode(data)}");
      return jsonDecode(data);
    } else {
      return [];
    }
  }
  static Future<dynamic> deleteFastingHistory(name)async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove("$name");
  }
}
