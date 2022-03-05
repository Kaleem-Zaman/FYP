import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestDetails extends StatefulWidget {
  static const id = "request_details";

  const RequestDetails({Key? key}) : super(key: key);

  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  final _fs = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Active Requests"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(15, 46, 94, 10),
        ),
        body: StreamBuilder(
          stream: _fs.collection('batchData').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Center(
                  child: ShowRequestDetailWidget(poNum: document['PO'],
                    party: document['Party'],
                    length: document['Length'],
                    quality: document['Quality'],
                    department: document['Department'],),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class ShowRequestDetailWidget extends StatelessWidget {
  dynamic poNum, party, length, quality, department;
  ShowRequestDetailWidget(
      {Key? key,
      required this.poNum,
      required this.party,
      required this.length,
      required this.quality,
      required this.department})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(15, 46, 94, 50),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(15, 46, 94, 100),
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                  offset: Offset(2.0, 7.0))
            ]),
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(10),
        height: 300,
        child: Column(
          children: [
            Table(
              border: TableBorder.all(color: Colors.white),
              children:  [
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "PO#",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "$poNum",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Party",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "$party",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Length",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "$length",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Quality",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "$quality",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Department",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "$department",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ]),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent)),
                  onPressed: () {},
                  child: Text("Deny"),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightGreen)),
                  onPressed: () {},
                  child: Text("Allow"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
