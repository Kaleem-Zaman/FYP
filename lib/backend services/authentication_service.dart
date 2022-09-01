import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/screens/sign_in_screen.dart';
import 'package:fyp/screens/view_requests.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class AuthService {
  String? username, password;
  dynamic status;

  login(String username, String password, BuildContext context) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("users").doc("owner");
    Map<String, dynamic> statusUpdate = {
      "status":"LOGGED IN"
    };
    documentReference.get().then(
      (DocumentSnapshot doc) {
        if(!doc.exists){
          MotionToast.error(
            description: Text("No user exists!"),
            title: Text("Login Failed"),
            position: MOTION_TOAST_POSITION.top,
            animationType: ANIMATION.fromTop,
          ).show(context);
        }
        else{
          final data = doc.data() as Map<String, dynamic>;
          if (username == data['username'] && password == data['password']) {
            documentReference.update(statusUpdate);
            Navigator.of(context).pushNamedAndRemoveUntil(ViewRequestsScreen.id, (route) => false);
          } else {
            MotionToast.error(
              description: Text("Invalid user credentials"),
              title: Text("Login Failed"),
              position: MOTION_TOAST_POSITION.top,
              animationType: ANIMATION.fromTop,
            ).show(context);
          }
        }
      },
      onError: (e) => print("Following error occurred: $e"),
    );
  }

  register(String username, String password, BuildContext context) {
    Map<String, dynamic> owner = ({
      "username": username,
      "password": password,
      "status": "LOGGED OUT",
    });
    try {
      DocumentReference doc =
          FirebaseFirestore.instance.collection("users").doc("owner");
      doc.set(owner);
      MotionToast.success(
        description: Text("User registered successfully"),
        title: Text("Success"),
        position:  MOTION_TOAST_POSITION.top,
        animationType: ANIMATION.fromTop,
        onClose: () => Navigator.of(context).pushNamedAndRemoveUntil(SignInScreen.id, (route) => false),
      ).show(context);
    } catch (e) {
      MotionToast.error(
        description: Text("Could not register user!"),
        title: Text("Registration Failed"),
        position:  MOTION_TOAST_POSITION.top,
        animationType: ANIMATION.fromTop,
      ).show(context);
    }
  }

  logout() async {
    Map<String, dynamic> updateStatus = {
      "status":"LOGGED OUT"
    };
    DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc("owner");
    docRef.update(updateStatus);
  }

  forgotPassword(var email, BuildContext context)  {
    DocumentReference documentReference =
      FirebaseFirestore.instance.collection("users").doc("owner");
    documentReference.get().then((DocumentSnapshot doc) {
     if(!doc.exists){
       MotionToast.error(
         description: Text("No user exists currently!"),
         title: Text("Cannot Proceed"),
         position:  MOTION_TOAST_POSITION.top,
         animationType: ANIMATION.fromTop,
       ).show(context);
     }
     else {
       if(email==null){
         MotionToast.error(
           description: Text("Please enter user email!"),
           title: Text("Cannot Proceed"),
           position:  MOTION_TOAST_POSITION.top,
           animationType: ANIMATION.fromTop,
         ).show(context);
       }
       else{
         DocumentReference docRef = FirebaseFirestore.instance.collection("verificationCode").doc("ownerCode");
         var num = Random(0).nextInt(1000);
         Map<String, dynamic> code = {
           "code":num
         };
         docRef.set(code);
         final Email verificationEmail = Email(
             body: "Enter this code in the screen on your app: $num",
             subject: "ABDCS: Owner password reset code",
             recipients: [email],
             isHTML: false
         );
         FlutterEmailSender.send(verificationEmail);
       }

     }
    });
  }
}
