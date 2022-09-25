import 'dart:convert';

AuthUserModel authUserModelFromJson(String str) => AuthUserModel.fromJson(json.decode(str));

String authUserModelToJson(AuthUserModel data) => json.encode(data.toJson());

class AuthUserModel {
    AuthUserModel({
        this.name,
        this.email,
    });

    String? name;
    String? email;

    factory AuthUserModel.fromJson(Map<String, dynamic> json) => AuthUserModel(
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
    };
}
