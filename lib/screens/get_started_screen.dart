
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/sign_in_screen.dart';
import 'package:fyp/screens/sign_up_screen.dart';
import 'package:fyp/screens/view_requests.dart';

import '../backend services/notification_service.dart';


class GetStartedScreen extends StatelessWidget {
  static const id = "get_started";
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("AB Textiles Dispatch Control App"),
                  const SizedBox(
                    height: 30,
                  ),
                  const CircleAvatar(
                    backgroundColor: Color.fromRGBO(241, 241, 241, 10),
                    backgroundImage: AssetImage("assets/image/logo.png"),
                    radius: 100,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                   Container(
                     margin: EdgeInsets.only(left: 15, right: 15),
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Color.fromRGBO(15, 46, 94, 50)
                     ),
                     child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(SignInScreen.id, (route) => false);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Center(child: Text("Sign In", style: TextStyle(fontSize: 20, color: Colors.white),)),
                            ],
                          ),
                        ),
                   ),

                  SizedBox(height: 25,),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(230, 230, 230, 10)
                    ),
                    child: FlatButton(
                      onPressed: () {
                        // CHANGES MADE HERE
                        Navigator.of(context).pushNamedAndRemoveUntil(SignUpScreen.id, (route) => false);

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(child: Text("Sign Up", style: TextStyle(fontSize: 20, color: Colors.black),)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        )),
    );
  }
}


