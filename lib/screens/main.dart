import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/backend%20services/firebaseAuthService.dart';
import 'package:fyp/screens/get_started_screen.dart';
import 'package:fyp/screens/previous_record.dart';
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
  dynamic checkOwnerStatus()  {
    DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc("owner");
    docRef.get().then(
        (DocumentSnapshot doc){
          if(!doc.exists){
            Get.off(() => GetStartedScreen());
          }
          else{
            final data = doc.data() as Map<String, dynamic>;
            if(data["status"] == "LOGGED OUT"){
              // if owner exists and is logged out
              Get.off(() => SignInScreen());
            }
            else if(data["status"]=="LOGGED IN"){
              // if owner exists and is logged in
              Get.off(() => ViewRequestsScreen());
            }
          }
        }
    );

  }
  @override
  Widget build(BuildContext context)  {
    FirebaseMessaging.instance.getToken().then((value) => saveToken(value));
    checkOwnerStatus();
    return  GetMaterialApp(

        initialRoute: GetStartedScreen.id,
        debugShowCheckedModeBanner: false,
        routes:{
          GetStartedScreen.id: (context) => GetStartedScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          SignInScreen.id: (context) => SignInScreen(),
          ViewRequestsScreen.id: (context) => ViewRequestsScreen(),
          PreviousRecord.id: (context) => PreviousRecord(),
        }
      );
  }
}
