import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/backend%20services/authentication_service.dart';
import 'package:fyp/screens/reports_screen.dart';
import 'package:fyp/screens/sign_in_screen.dart';
import 'package:fyp/screens/view_requests.dart';
import '../custom widgets/record_table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PreviousRecord extends StatefulWidget {
  static const id = "previous_record";
  const PreviousRecord({Key? key}) : super(key: key);

  @override
  _PreviousRecordState createState() => _PreviousRecordState();
}

class _PreviousRecordState extends State<PreviousRecord> {
  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Previously Allowed Requests"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(15, 46, 94, 10),
        ),
        drawer: Drawer(
          child: Container(
            color: Color.fromRGBO(15, 46, 94, 10),
            child: Column(
              children: [
                Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        child: Icon(Icons.person),
                        radius: 30,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "owner@gmail.com",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 2,
                  thickness: 2,
                  indent: 7,
                  endIndent: 7,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ViewRequestsScreen.id);
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.view_agenda,
                      color: Colors.white,
                    ),
                    title: Text("View Active Requests",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PreviousRecord.id);
                  },
                  child: const ListTile(
                    selected: true,
                    selectedTileColor: Colors.black,
                    leading: Icon(
                      Icons.receipt_outlined,
                      color: Colors.white,
                    ),
                    title: Text("View Requests Record",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Reports.id);
                  },
                  child: const ListTile(
                    selected: true,
                    leading: Icon(
                      Icons.data_usage,
                      color: Colors.white,
                    ),
                    title: Text("Reports",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    auth.logout();
                    Navigator.of(context).pushNamedAndRemoveUntil(SignInScreen.id, (route) => false);
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title:
                        Text("Sign Out", style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("requests").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: snapshot.data!.docs
                    .where((element) => element['Status'] != "Pending Approval")
                    .map((e) {
                  return RecordTable(
                      poNumber: e["PO"],
                      partyName: e["Party"],
                      length: e["Length"],
                      quality: e["Quality"]);
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
