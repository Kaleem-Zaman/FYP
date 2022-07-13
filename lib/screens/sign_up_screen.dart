import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/backend%20services/authentication_service.dart';
import 'package:fyp/backend%20services/firebaseAuthService.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class SignUpScreen extends StatefulWidget {
  static const id = "sign_up";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email, password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromRGBO(15, 46, 94, 50),
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Color.fromRGBO(15, 46, 94, 500),
            ),
            body: ListView(children: [
              const Center(
                child: Text(
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      hintText: "Name",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0)),
                      hintStyle: TextStyle(color: Colors.white)),
                  onChanged: (value) {
                    //
                  },
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
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0)),
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
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0)),
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
                          description: const Text("Please fill in the credentials"),
                          title: const Text("Empty Credentials"),
                          position: MOTION_TOAST_POSITION.top,
                          animationType: ANIMATION.fromTop,
                        ).show(context);
                      } else {
                        AuthService auth = AuthService();
                        auth.register(email!, password!, context);
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
              Center(
                child: RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "Already have an account?",
                      style: TextStyle(color: Colors.white)),
                  TextSpan(
                      text: " Sign In!",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ))
                ])),
              ),
            ])));
  }
}
