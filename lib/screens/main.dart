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



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      const Root()
  );
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
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
