
import 'package:flutter/material.dart';
import 'package:fyp/screens/sign_in_screen.dart';
import 'package:fyp/screens/sign_up_screen.dart';

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
            Text(
              "Welcome",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text("Owner Module for Textile Product Dispatch Authentication"),
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              backgroundColor: Color.fromRGBO(241, 241, 241, 10),
              backgroundImage: AssetImage("assets/image/logo.png"),
              radius: 100,
            ),
            SizedBox(
              height: 30,
            ),
             Container(
               margin: EdgeInsets.only(left: 15, right: 15),
               padding: EdgeInsets.all(10),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color: Color.fromRGBO(241, 241, 241, 10)
               ),
               child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignInScreen.id);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text("Sign In", style: TextStyle(fontSize: 20),)),
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
                  color: Color.fromRGBO(15, 46, 94, 50)
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUpScreen.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text("Sign Up", style: TextStyle(fontSize: 20, color: Colors.white),)),
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
