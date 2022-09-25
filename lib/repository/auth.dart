import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_flutter/model/auth-model/auth_user_model.dart';
import 'package:fitness_app_flutter/model/daysModel.dart';
import 'package:fitness_app_flutter/utils/snakbar.dart';

class Auth {
  static Future<dynamic> crateUser(email, password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
          return userCredential;
    } on FirebaseAuthException catch (e) {
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

  static Future<void> signOut(context) async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
       showSnackbar(context, e.message);
    }
  }

 static Future resetPassword(email,context)async{
  try{
   await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
   showSnackbar(context, "Password reset email send check your mail");
  }on FirebaseAuthException catch(e){
    showSnackbar(context, e.message);
  }
 }
}
