import 'package:flutter/material.dart';
import 'package:fyp/screens/view_requests.dart';

class PreviousRecord extends StatefulWidget {
  static const id = "previous_record";
  const PreviousRecord({Key? key}) : super(key: key);

  @override
  _PreviousRecordState createState() => _PreviousRecordState();
}

class _PreviousRecordState extends State<PreviousRecord> {
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
                  onTap: (){
                    Navigator.pushNamed(context, ViewRequestsScreen.id);
                  },
                  child: ListTile(
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
                  onTap: (){
                    Navigator.pushNamed(context, PreviousRecord.id);
                  },
                  child: ListTile(
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
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: Text("Sign Out", style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ),
        body: ListView(children: [
          RecordTable(),
          RecordTable(),
          RecordTable(),
          RecordTable(),
          RecordTable(),
        ]),
      ),
    );
  }
}

class RecordTable extends StatelessWidget {
  const RecordTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(15, 46, 94, 10),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
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
          children: const [
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
                  "1235",
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
                  "MariaB",
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
                  "12m",
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
                  "Cashmere",
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
