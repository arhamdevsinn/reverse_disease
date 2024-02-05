import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/model/chat/chat_model.dart';
import 'package:fitness_app_flutter/repository/chat.dart';
import 'package:fitness_app_flutter/utils/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../model/chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  Chat chat = Chat();
  CollectionReference userChat = FirebaseFirestore.instance.collection("Chat");
  late ChatModel model;
  var user = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        elevation: 0.0,
        leading: const BackButton(color: blackcolor),
        backgroundColor: whitecolor,
        title: font16Textbold(
          text: "Chat with poonam",
        ),
      ),
      body: StreamBuilder(
          stream: userChat
              .doc(FirebaseAuth.instance.currentUser?.email)
              .collection("messages")
              .orderBy("messagetime", descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<ChatModel> chatList = [];

            QuerySnapshot data = snapshot.data as QuerySnapshot;
               var i=0;
            data.docs
                .map(((e) {
                  model = ChatModel.fromJson(e.data() as Map<String, dynamic>);
                  chatList.insert(i,model);
                  i++;
                }))
                .toList()
                .toSet();

            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: ListView.builder(
                    reverse: true,

                    itemCount: chatList.length,
                    // shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),

                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (chatList[index].sender == "aw@gmail.com"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: (chatList[index].sender == "aw@gmail.com"
                                  ? Colors.blue[400]
                                  : themeColor.withOpacity(0.8)),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              chatList[index].message.toString(),
                              style: const TextStyle(
                                  fontSize: 15, color: whitecolor),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            // maxLines: null,
                            decoration: const InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            var data = {
                              "sender":
                                  FirebaseAuth.instance.currentUser!.email,
                              "reciever": "aw78001@gmail.com",
                              "message": messageController.text,
                              "messagetime": DateFormat.yMd()
                                  .add_jm()
                                  .format(DateTime.now())
                            };
                            if (messageController.text != "" ||
                                messageController.text.isNotEmpty) {
                              ChatModel chatModel = ChatModel.fromJson(data);
                              chat.chatData(chatModel.toJson());
                              messageController.clear();
                            } else if (messageController.text == "") {
                              showSnackbar(context, "Write something");
                            }
                          },
                          backgroundColor: themeColor,
                          elevation: 0,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
