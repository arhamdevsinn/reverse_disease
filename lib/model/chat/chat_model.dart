import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
    ChatModel({
        this.sender,
        this.reciever,
        this.message,
        this.messagetime,
    });

    String? sender;
    String? reciever;
    String? message;
    String? messagetime;

    factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        sender: json["sender"],
        reciever: json["reciever"],
        message: json["message"],
        messagetime: json["messagetime"],
    );

    Map<String, dynamic> toJson() => {
        "sender": sender,
        "reciever": reciever,
        "message": message,
        "messagetime": messagetime,
    };
}
