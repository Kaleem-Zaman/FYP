import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/backend%20services/firebaseAuthService.dart';
import 'package:fyp/screens/get_started_screen.dart';
import 'package:fyp/screens/loading_screen.dart';
import 'package:fyp/screens/previous_record.dart';
import 'package:fyp/screens/reports_screen.dart';
import 'package:fyp/screens/request_details.dart';
import 'package:fyp/screens/sign_in_screen.dart';
import 'package:fyp/screens/sign_up_screen.dart';
import 'package:fyp/screens/view_requests.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:get/get.dart";
import "package:firebase_messaging/firebase_messaging.dart";




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      const Root()
  );
}


class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);
  void saveToken(var token)   {
    DocumentReference docref = FirebaseFirestore.instance.collection("pushToken").doc("token1");
    Map<String, dynamic> tokenMap = {
      "deviceToken":token,
    };
    docref.set(tokenMap);
  }

  @override
  Widget build(BuildContext context)  {
    FirebaseMessaging.instance.getToken().then((value) => saveToken(value));
    return  GetMaterialApp(

        initialRoute: CheckOwnerStatus.id,
        debugShowCheckedModeBanner: false,
        routes:{
          CheckOwnerStatus.id: (context) => CheckOwnerStatus(),
          GetStartedScreen.id: (context) => GetStartedScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          SignInScreen.id: (context) => SignInScreen(),
          ViewRequestsScreen.id: (context) => ViewRequestsScreen(),
          Reports.id: (context) => Reports(),
          PreviousRecord.id: (context) => PreviousRecord(),
        }
      );
  }
}
