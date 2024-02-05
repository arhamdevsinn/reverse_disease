import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chat{
   CollectionReference users =
      FirebaseFirestore.instance.collection("Chat");
  Future chatData(data) async {
  return await users.doc(FirebaseAuth.instance.currentUser?.email).collection("messages").add(data) ;

  }
}
// FirebaseAuth.instance.currentUser!.email