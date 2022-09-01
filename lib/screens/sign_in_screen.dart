import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/backend%20services/authentication_service.dart';
import 'package:fyp/backend%20services/firebaseAuthService.dart';
import 'package:fyp/screens/view_requests.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class SignInScreen extends StatefulWidget {
  static const id = "sign_in";
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? email, password; // credentials
  AuthService auth = AuthService();
  void checkCredentials() {
    if (email == null || password == null || email == "" || password == "") {
      MotionToast.error(
        description: Text("Please fill in the credentials"),
        title: Text("Empty Credentials"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromRGBO(15, 46, 94, 50),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(15, 46, 94, 500),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          const Center(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/image/logo.png"),
              radius: 100,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  hintText: "Email",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                  hintStyle: TextStyle(color: Colors.white)),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: "Password",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                  hintStyle: TextStyle(color: Colors.white)),
              onChanged: (value) {
                password = value;
              },
            ),
          ),
          Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blueAccent,
              ),
              child: FlatButton(
                onPressed: () {
                  if (email == "" ||
                      password == "" ||
                      email == null ||
                      password == null) {
                    MotionToast.error(
                      description: Text("Please fill in the credentials"),
                      title: Text("Empty Credentials"),
                      position: MOTION_TOAST_POSITION.top,
                      animationType: ANIMATION.fromTop,
                    ).show(context);
                  } else {
                    AuthService auth = AuthService();
                    auth.login(email!, password!, context);
                  }
                  //MotionToast.error(description: Text("Please fill in the credentials"), title: Text("Empty Credentials"),).show(context);
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              )),
          TextButton(
              onPressed: (){
                Get.defaultDialog(
                  title: "Verification Email",
                  middleText: "Are you sure to reset password?\nAn email with a code will be sent to you",
                  textConfirm: "Yes",
                  confirmTextColor: Colors.white,
                  textCancel: "No",
                  onConfirm: (){
                      auth.forgotPassword(email, context);
                      Navigator.pop(context);
                  },
                  onCancel: (){
                    Navigator.of(context).pop();
                  }
                );
              },
              child: const Text("Forgot Password?", style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    ));
  }
}
