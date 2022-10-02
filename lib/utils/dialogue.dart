import 'package:fitness_app_flutter/utils/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';
import '../model/fastingModel/fasting_model.dart';
import '../repository/fastingPref/fasting_history_logic.dart';

Future saveDataDialog({fastingTime, startTime, @required context}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Save Fasting Time"),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
                shape: const StadiumBorder(),
                child: const Text('Save'),
                onPressed: () async {
                  var end=   DateFormat.yMd()
                                    .add_jm()
                                    .format(DateTime.now());
                  Map<String,dynamic> data = {
                    "fastingDuration": fastingTime,
                    "startFast": startTime,
                    "endFast":end,
                  };
                  FastingHistoryModel model =
                      FastingHistoryModel.fromJson(data);
                  await FastingHistoryLogic.addFastigLogic(
                      data: model, context: context, name: "fastingHistory").then((value) {
                        Navigator.pop(context);
                      });
                }),
          ],
        );
      });
}
