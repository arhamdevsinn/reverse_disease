import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StepsStorage{
   CollectionReference users =
      FirebaseFirestore.instance.collection("users");
       Future<dynamic> enterData(data)async{
       return await users.doc("initial-steps").set(data);
      }
}