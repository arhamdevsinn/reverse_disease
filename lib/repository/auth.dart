import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_flutter/model/auth-model/auth_user_model.dart';
import 'package:fitness_app_flutter/model/daysModel.dart';
import 'package:fitness_app_flutter/utils/loading_dialogue.dart';
import 'package:fitness_app_flutter/utils/snakbar.dart';
import 'package:flutter/material.dart';

class Auth {
  static Future<dynamic> crateUser(email, password, context) async {
    try {
      // debugger();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
          return userCredential;
    } on FirebaseAuthException catch (e) {
      // debugger();
      showSnackbar(context, e.message);
    } catch (e) {
      print("This is exception $e");
    }
  }

  static Future<dynamic> loginUser(email, password, context) async {
    try {
      
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          print(userCredential.user);
          return userCredential; 
          
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message);
    } catch (e) {
      print("This is exception $e");
    }
  }

  static signOut(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      return "done";
    } on FirebaseAuthException catch (e) {
       showSnackbar(context, e.message);
    }
  }

 static Future resetPassword(email,context)async{
  try{
   await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
   showSnackbar(context, "Please! Check your Email and Verify");
   Navigator.pop(context);
  }on FirebaseAuthException catch(e){
    showSnackbar(context, e.message);
  }
 }
}
