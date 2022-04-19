import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/previous_record.dart';
import 'package:fyp/screens/request_details.dart';
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
                      children: [
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
                  Divider(
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
                    child: ListTile(
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
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PreviousRecord.id);
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.receipt_outlined,
                        color: Colors.white,
                      ),
                      title: Text("View Requests Record",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignInScreen.id);
                    },
                    child: ListTile(
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

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

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
              })),
    );
  }
}

class RequestTile extends StatelessWidget {
  String po_number;
  String party_name, length, quality, status, id;
  RequestTile(
      {Key? key,
      required this.po_number,
      required this.party_name,
      required this.quality,
      required this.length,
      required this.status,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(15, 46, 94, 10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(15, 46, 94, 100),
                blurRadius: 15.0,
                spreadRadius: 5.0,
                offset: Offset(2.0, 7.0))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "PO#",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: " $po_number",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ]),
              ),
              SizedBox(
                height: 5,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Party:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: " $party_name",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ]),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RequestDetails(
                            po_number: po_number,
                            party_name: party_name,
                            length: length,
                            quality: quality,
                            status: status,
                            id: id,
                          )));
            },
            child: Row(
              children: [
                Text("Details "),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                ),
              ],
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(106, 125, 155, 10))),
          ),
        ],
      ),
    );
  }
}
