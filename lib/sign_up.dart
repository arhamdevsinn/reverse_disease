import 'package:fitness_app_flutter/login_screen.dart';
import 'package:fitness_app_flutter/repository/auth.dart';
import 'package:fitness_app_flutter/repository/fire_store.dart';
import 'package:fitness_app_flutter/utils/snakbar.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:fitness_app_flutter/widgets/myTextField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants/colors.dart';
import 'customBotttomNav.dart';
import 'model/auth-model/auth_user_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

final _formKey2 = GlobalKey<FormState>();
bool checkValue = false;

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confermPassController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confermPassController.dispose();
  }
  FireStoreData? fireStoreData = FireStoreData();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        backgroundColor: whitecolor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                   const Center(
                      child:  Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: themeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 10),
                    // const Text(
                    //   "Sign up to continue",
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     color: themeColor,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: nameController,
                      errorText: "Please enter your name",
                      hintText: "Name",
                      prefixIcon: const Icon(
                        Icons.person,
                        color: themeColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: emailController,
                      errorText: "Please enter your email or phone number",
                      hintText: "Email or Phone",
                      prefixIcon: const Icon(
                        Icons.email,
                        color: themeColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      passVlidate: true,
                      controller: passController,
                      errorText: "Please enter your password",
                      hintText: "Password",
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: themeColor,
                      ),
                    ),
                    // const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    // MyTextField(
                    //   conferPass: passController.text,
                    //   controller: confermPassController,
                    //   errorText: "Re-enter your password",
                    //   hintText: "Conferm Password",
                    //   prefixIcon: const Icon(
                    //     Icons.lock,
                    //     color: themeColor,
                    //   ),
                    // ),
                     TextFormField(
      controller: confermPassController,
      decoration: InputDecoration(
          prefixIcon: const Icon(
                        Icons.lock,
                        color: themeColor,
                      ),
          prefixIconColor: themeColor,
         
          hintText: "",
          hintStyle:
              TextStyle(fontSize: 15, color: blackcolor.withOpacity(0.5))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Confer your password";
        }
        else if(confermPassController.text!=passController.text){
          return "Passwor is not matched";
        }
      
        return null;
      },
    ),
                
                    const SizedBox(height: 30),
                    CustomButton(
                      buttonText: "Sign Up",
                      color: themeColor,
                      onTap: () {
                        if (_formKey2.currentState!.validate()) {
                         

                          var data = {
                            "name": nameController.text,
                            "email": emailController.text
                          };
                          

                          Auth.crateUser(emailController.text,
                                  passController.text, context)
                              .then((value) async {
                                if(value!=null){
                           AuthUserModel model = AuthUserModel.fromJson(data);
                            fireStoreData!.userAuthInfo(model.toJson());
                            showSnackbar(
                                context, "Created account scucessfully");
                            Future.delayed(const Duration(seconds: 2),(){
                           Navigator.pop(context);
                            });}
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Bach to the Login Screen ',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 15),
                            children: <TextSpan>[
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Get.to(const LoginScreen());
                                    Navigator.pop(context);
                                  },
                                text: ' Log In',
                                style: const TextStyle(
                                    color: themeColor, fontSize: 15),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
