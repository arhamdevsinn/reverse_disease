// To parse this JSON data, do
//
//     final fastingHistoryModel = fastingHistoryModelFromJson(jsonString);

import 'dart:convert';

FastingHistoryModel fastingHistoryModelFromJson(String str) => FastingHistoryModel.fromJson(json.decode(str));

String fastingHistoryModelToJson(FastingHistoryModel data) => json.encode(data.toJson());

class FastingHistoryModel {
    FastingHistoryModel({
        this.fastingDuration,
        this.startFast,
        this.endFast,
    });

    dynamic fastingDuration;
    dynamic startFast;
    dynamic endFast;

    factory FastingHistoryModel.fromJson(Map<String, dynamic> json) => FastingHistoryModel(
        fastingDuration: json["fastingDuration"],
        startFast: json["startFast"],
        endFast: json["endFast"],
    );

    Map<String, dynamic> toJson() => {
        "fastingDuration": fastingDuration,
        "startFast": startFast,
        "endFast": endFast,
    };
}
