import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/screens/sign_in_screen.dart';
import 'package:fyp/screens/view_requests.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

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
      },
      onError: (e) => print("Error getting document: $e"),
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
}
