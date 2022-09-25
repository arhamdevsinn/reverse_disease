import 'dart:convert';

HydrationModel hydrationModelFromJson(String str) => HydrationModel.fromJson(json.decode(str));

String hydrationModelToJson(HydrationModel data) => json.encode(data.toJson());

class HydrationModel {
    HydrationModel({
        this.liquid,
        this.liquietype,
        this.quantity,
        this.date,
    });

    final String? liquid;
    final String? liquietype;
    dynamic quantity;
    final String? date;

    factory HydrationModel.fromJson(Map<String, dynamic> json) => HydrationModel(
        liquid: json["liquid"],
        liquietype: json["liquietype"],
        quantity: json["quantity"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "liquid": liquid,
        "liquietype": liquietype,
        "quantity": quantity,
        "date": date,
    };
}
