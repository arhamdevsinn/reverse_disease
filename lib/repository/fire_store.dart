import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FireStoreData {
     
  CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  Future userAuthInfo(data) async {
   return await users.doc(FirebaseAuth.instance.currentUser!.uid).set(data);
  }

  // Future addCoachFireStoreData(data) async {
  //   CollectionReference coach =
  //       FirebaseFirestore.instance.collection('job-seeker');
  //   await coach.add(data);
  // }
}