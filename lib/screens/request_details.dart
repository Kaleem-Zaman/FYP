import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class RequestDetails extends StatefulWidget {
  String po_number;
  String party_name;
  String length;
  String quality;
  String status;
  String id;
  RequestDetails(
      {Key? key,
      required this.po_number,
      required this.party_name,
      required this.length,
      required this.quality,
      required this.status,
      required this.id})
      : super(key: key);

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
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Center(
                  child: ShowRequestDetailWidget(
                    poNum: widget.po_number,
                    party: widget.party_name,
                    length: widget.length,
                    quality: widget.quality,
                    status: widget.status,
                    id: widget.id,
                  ),
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
  dynamic poNum, party, length, quality, status, id;
  ShowRequestDetailWidget({
    Key? key,
    required this.poNum,
    required this.party,
    required this.length,
    required this.quality,
    required this.status,
    required this.id
  }) : super(key: key);

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
        height: 320,
        child: Column(
          children: [
            Table(
              border: TableBorder.all(color: Colors.white),
              children: [
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
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Status",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "$status",
                      style: TextStyle(fontSize: 15, color: Colors.redAccent),
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
                  onPressed: () async {
                    DocumentReference docref = FirebaseFirestore.instance
                        .collection("requests")
                        .doc("$id");
                    Map<String, dynamic> docMap = ({
                      "Status": "DENY",
                    });
                    DocumentSnapshot snap = await docref.get();
                    if (snap.exists) {
                      await docref.update(docMap);
                      MotionToast.delete(
                        description: Text("Status has been set to: DENY"),
                        borderRadius: 5,
                        title: Text("User Update"),
                      ).show(context);
                    }
                    else{
                      MotionToast.error(
                        description: Text("Some error occurred while updating the status! Please check you are connected to the internet and try again!"),
                        borderRadius: 5,
                        title: Text("User Update"),
                      ).show(context);
                    }

                  },
                  child: Text("Deny"),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightGreen)),
                  onPressed: () async {
                    DocumentReference docref = FirebaseFirestore.instance
                        .collection("requests")
                        .doc("$id");
                    Map<String, dynamic> docMap = ({
                      "Status": "ALLOW",
                    });
                    DocumentSnapshot snap = await docref.get();
                    if (snap.exists) {
                      await docref.update(docMap);
                      MotionToast.success(
                        description: Text("Status has been set to: ALLOW"),
                        borderRadius: 5,
                        title: Text("User Update"),
                      ).show(context);
                    }
                    else{
                      MotionToast.error(
                        description: Text("Some error occurred while updating the status! Please check you are connected to the internet and try again!"),
                        borderRadius: 5,
                        title: Text("User Update"),
                      ).show(context);
                    }

                  },
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
