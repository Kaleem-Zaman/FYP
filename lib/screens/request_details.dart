import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/custom widgets/show_request_detail.dart';

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


