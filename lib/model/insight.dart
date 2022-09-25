
import 'dart:convert';

InsightModel insightModelFromJson(String str) => InsightModel.fromJson(json.decode(str));

String insightModelToJson(InsightModel data) => json.encode(data.toJson());

class InsightModel {
    InsightModel({
        this.trending,
        this.abcOfFasting,
        this.whatCanIEat,
        this.fastingExplained,
        this.eatingHealthy,
        this.healthyWeight,
        this.healthyMovement,
        this.gettingStarted,
        this.bodyAndMind,
        this.fastingChallenge,
    });

    Trending? trending;
    List<AbcOfFasting>? abcOfFasting;
    List<AbcOfFasting>? whatCanIEat;
    List<AbcOfFasting>? fastingExplained;
    List<AbcOfFasting>? eatingHealthy;
    List<AbcOfFasting>? healthyWeight;
    List<AbcOfFasting>? healthyMovement;
    List<AbcOfFasting>? gettingStarted;
    List<AbcOfFasting>? bodyAndMind;
    List<AbcOfFasting>? fastingChallenge;

    factory InsightModel.fromJson(Map<String, dynamic> json) => InsightModel(
        trending: Trending.fromJson(json["Trending"]),
        abcOfFasting: List<AbcOfFasting>.from(json["ABC of fasting"].map((x) => AbcOfFasting.fromJson(x))),
        whatCanIEat: List<AbcOfFasting>.from(json["what can i eat"].map((x) => AbcOfFasting.fromJson(x))),
        fastingExplained: List<AbcOfFasting>.from(json["fasting explained"].map((x) => AbcOfFasting.fromJson(x))),
        eatingHealthy: List<AbcOfFasting>.from(json["eating healthy"].map((x) => AbcOfFasting.fromJson(x))),
        healthyWeight: List<AbcOfFasting>.from(json["healthy weight"].map((x) => AbcOfFasting.fromJson(x))),
        healthyMovement: List<AbcOfFasting>.from(json["healthy movement"].map((x) => AbcOfFasting.fromJson(x))),
        gettingStarted: List<AbcOfFasting>.from(json["getting started"].map((x) => AbcOfFasting.fromJson(x))),
        bodyAndMind: List<AbcOfFasting>.from(json["body and mind "].map((x) => AbcOfFasting.fromJson(x))),
        fastingChallenge: List<AbcOfFasting>.from(json["fasting challenge"].map((x) => AbcOfFasting.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Trending": trending?.toJson(),
        "ABC of fasting": List<dynamic>.from(abcOfFasting!.map((x) => x.toJson())),
        "what can i eat": List<dynamic>.from(whatCanIEat!.map((x) => x.toJson())),
        "fasting explained": List<dynamic>.from(fastingExplained!.map((x) => x.toJson())),
        "eating healthy": List<dynamic>.from(eatingHealthy!.map((x) => x.toJson())),
        "healthy weight": List<dynamic>.from(healthyWeight!.map((x) => x.toJson())),
        "healthy movement": List<dynamic>.from(healthyMovement!.map((x) => x.toJson())),
        "getting started": List<dynamic>.from(gettingStarted!.map((x) => x.toJson())),
        "body and mind ": List<dynamic>.from(bodyAndMind!.map((x) => x.toJson())),
        "fasting challenge": List<dynamic>.from(fastingChallenge!.map((x) => x.toJson())),
    };
}

class AbcOfFasting {
    AbcOfFasting({
        this.title,
        this.option,
    });

    String? title;
    List<Option>? option;

    factory AbcOfFasting.fromJson(Map<String, dynamic> json) => AbcOfFasting(
        title: json["title"],
        option: List<Option>.from(json["option"].map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "option": List<dynamic>.from(option!.map((x) => x.toJson())),
    };
}

class Option {
    Option({
        this.title,
        this.dics,
    });

    String? title;
    String? dics;

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        title: json["title"],
        dics: json["Dics"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "Dics": dics,
    };
}

class Trending {
    Trending({
        this.title,
        this.options,
    });

    String? title;
    List<Option>? options;

    factory Trending.fromJson(Map<String, dynamic> json) => Trending(
        title: json["title"],
        options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "options": List<dynamic>.from(options!.map((x) => x.toJson())),
    };
}
