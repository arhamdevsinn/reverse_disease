import 'package:fitness_app_flutter/model/fastingModel/fasting_model.dart';
import 'package:fitness_app_flutter/repository/fastingPref/fasting_history_pref.dart';
import 'package:fitness_app_flutter/repository/sharedPref/shared_pref.dart';

import '../../utils/snakbar.dart';

class FastingHistoryLogic {
  static Future addFastigLogic({
      // FastingHistoryModel?
       data, name, context}) async {
    var getData = await FastingHistoryPref.readFastingHistory(name);

    if (getData.isNotEmpty) {
      getData.add(data);
      await HydrationPreferences.saveHydrationData(getData, name);
      showSnackbar(context, "Time saved succesfully");
    } else {
      List listData = [];
      listData.add(data);
      await HydrationPreferences.saveHydrationData(listData, name);
      showSnackbar(context, "Time save succesfully");
    }
  }
}
