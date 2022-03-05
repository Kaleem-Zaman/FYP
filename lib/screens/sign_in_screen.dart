import 'package:flutter/material.dart';
import 'package:fyp/screens/view_requests.dart';

class SignInScreen extends StatefulWidget {
  static const id = "sign_in";
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/image/logo.png"),
              radius: 100,
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
                onPressed: () {
                  Navigator.pushNamed(context, ViewRequestsScreen.id);
                },
                child: Text("Sign In"),
              )),
          Center(
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(color: Colors.white)),
              TextSpan(
                  text: " Sign Up!",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ))
            ])),
          )
        ],
      ),
    ));
  }
}
