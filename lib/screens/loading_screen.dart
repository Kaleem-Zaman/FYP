import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/sign_in_screen.dart';
import 'package:fyp/screens/view_requests.dart';
import "package:get/get.dart";

import 'get_started_screen.dart';
class CheckOwnerStatus extends StatefulWidget {
  static const id = "loading_screen";
  const CheckOwnerStatus({Key? key}) : super(key: key);

  @override
  _CheckOwnerStatusState createState() => _CheckOwnerStatusState();
}

class _CheckOwnerStatusState extends State<CheckOwnerStatus> {
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
  void initState() {
    checkOwnerStatus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                  image: AssetImage("assets/image/loader.gif")
              ),
              SizedBox(height: 10,),
              Text("Setting things up...", style: TextStyle(fontSize: 20, color: Colors.blueAccent),),
            ],
          ),
        ),
      ),
    );
  }
}
