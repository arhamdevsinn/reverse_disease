import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chat{
   CollectionReference users =
      FirebaseFirestore.instance.collection("Chat");
  Future chatData(data) async {
  return await users.doc("aw78001@gmail.com").collection("messages").add(data) ;

  }
}
// FirebaseAuth.instance.currentUser!.email