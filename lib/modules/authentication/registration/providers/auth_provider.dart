import 'package:app_links/app_links.dart';
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
       await sendVerificationEmail(user);
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


  Future<void> sendVerificationEmail(User user) async {
    try {
      await user.sendEmailVerification();
      handleDeepLinks();

      print("✅ Email verification sent to: ${user.email}");
    } catch (e) {
      print("❌ Error sending email verification: $e");
    }
  }


  void handleDeepLinks() async {
    print("Checking for deep links...");
    final appLinks = AppLinks();

    appLinks.getInitialLinkString().then((link) {
      if (link != null) {
        print("Received deep link on startup: $link");
        processDeepLink(link);
      } else {
        print("❌ No deep link detected at startup.");
      }
    }).catchError((error) {
      print("🚨 Error getting initial link: $error");
    });

    appLinks.stringLinkStream.listen((link) {
      if (link != null) {
        print("Received deep link in runtime: $link");
        processDeepLink(link);
      } else {
        print("❌ No deep link detected in runtime.");
      }
    }, onError: (error) {
      print("🚨 Error in uriLinkStream: $error");
    });
  }


  void processDeepLink(String link) {
    print("🔗 Processing deep link: $link");
    Uri uri = Uri.parse(link);
    if (uri.queryParameters['mode'] == 'verifyEmail' &&
        uri.queryParameters.containsKey('oobCode')) {
      String oobCode = uri.queryParameters['oobCode']!;
      print("✅ This is an email verification link with oobCode: $oobCode");
      verifyEmailWithFirebase(oobCode);
    } else {
      print("❌ Not an email verification link.");
    }
  }



  void verifyEmailWithFirebase(String oobCode) async {
    try {
      await FirebaseAuth.instance.applyActionCode(oobCode);
      await FirebaseAuth.instance.currentUser?.reload();

      if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
        print("✅ Email verified successfully!");
        Get.offAll(() => NewsletterScreen());
      } else {
        print("❌ Email verification failed.");
      }
    } catch (e) {
      print("❌ Error verifying email: $e");
    }
  }

}