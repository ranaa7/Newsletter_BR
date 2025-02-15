import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsletter_blueribbon_task/modules/newsletter/screens/newsletter_screen.dart';

class AuthProvider  extends ChangeNotifier{

  FirebaseAuth auth = FirebaseAuth.instance;
  void signout() async {
    await auth.signOut();

   // Get.offAll(LoginScreen());
  }

  void signup(String email, String password, String name) async {
    try {
     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );



      User? user = userCredential.user;


     if (user != null) {
       await user.sendEmailVerification();
       print("✅ Email verification sent to: ${user.email}");
       Get.snackbar('Success', 'Account created successfully. Check your email for verification.',
           snackPosition: SnackPosition.BOTTOM);
     }




    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The email address is already in use',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Something went wrong: ${e.message}',
            snackPosition: SnackPosition.BOTTOM);
      }
    }

  }




}