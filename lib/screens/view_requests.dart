import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/previous_record.dart';
import 'package:fyp/custom widgets/request_tile.dart';
import 'package:fyp/screens/sign_in_screen.dart';

class ViewRequestsScreen extends StatefulWidget {
  static const id = "view_requests";
  const ViewRequestsScreen({Key? key}) : super(key: key);

  @override
  _ViewRequestsScreenState createState() => _ViewRequestsScreenState();
}

class _ViewRequestsScreenState extends State<ViewRequestsScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Active Requests"),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(15, 46, 94, 10),
            actions: [
              Container(
                padding: EdgeInsets.only(right: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ),
            ],
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
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ViewRequestsScreen.id);
                    },
                    child: const ListTile(
                      selected: true,
                      selectedTileColor: Colors.black,
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
                      Navigator.pushNamed(context, SignInScreen.id);
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      title: Text("Sign Out",
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("requests").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else {
                  return ListView(
                      children: snapshot.data!.docs.where((element) => element['Status']=="Pending Approval").map((document) {

                        return RequestTile(
                          po_number: document['PO'],
                          party_name: document['Party'],
                          quality: document['Quality'],
                          length: document['Length'],
                          status: document['Status'],
                          id: document.id,
                        );
                      }).toList());
                }

              })),
    );
  }
}


