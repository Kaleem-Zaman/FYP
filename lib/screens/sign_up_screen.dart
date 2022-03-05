import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const id = "sign_up";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(15, 46, 94, 50),
            appBar: AppBar(elevation: 0.0, backgroundColor: Color.fromRGBO(15, 46, 94, 500),),
            body: ListView(children: [
              Center(
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
                  decoration: InputDecoration(
                      hintText: "Name",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                      hintStyle: TextStyle(color: Colors.white)),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                      hintStyle: TextStyle(color: Colors.white)),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                      hintStyle: TextStyle(color: Colors.white)),
                  onChanged: (value) {
                    //
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
                    onPressed: () {},
                    child: Text("Sign Up"),
                  )),
              Center(
                child: RichText(
                    text: TextSpan(children: [
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
