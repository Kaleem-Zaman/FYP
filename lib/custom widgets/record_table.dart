import 'package:flutter/material.dart';

class RecordTable extends StatelessWidget {
  String poNumber, partyName, length, quality;
  RecordTable({
    Key? key,
    required this.poNumber,
    required this.partyName,
    required this.length,
    required this.quality,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(15, 46, 94, 10),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(15, 46, 94, 100),
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                  offset: Offset(
                      2.0,
                      7.0
                  )
              )
            ]
        ),
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(25),

        child: Table(
          border: TableBorder.all(color: Colors.white),
          children:  [
            TableRow(children: [
              const Padding(
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
                  "$poNumber",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              const Padding(
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
                  "$partyName",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ]),
            TableRow(children: [
              const Padding(
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
              const Padding(
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
            const TableRow(children: [
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
                  "Printing",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}