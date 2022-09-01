import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/previous_record.dart';
import 'package:fyp/screens/sign_in_screen.dart';
import 'package:fyp/screens/view_requests.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../backend services/authentication_service.dart';

class Reports extends StatefulWidget {
  static const id = "reports";
  const Reports({Key? key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  dynamic dispatchDigital="...", dispatchLocal="...", numOfErrors="...", totalDispatches="...";
  num? numOfErrorsLocal=0, numOfErrorsDigital=0, dispatchesA = 0, dispatchesB = 0,
      dispatchesC = 0, dispatchesX = 0, dispatchesY = 0, dispatchesZ = 0;
  int touchedIndex = -1;

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Local Packing';
        break;
      case 3:
        text = 'Digital Packing';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(text, style: style),
    );
  }
  Widget getTitlesParty(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'A';
        break;
      case 2:
        text = 'B';
        break;
      case 3:
        text = 'C';
        break;
      case 4:
        text = 'X';
        break;
      case 5:
        text = 'Y';
        break;
      case 6:
        text = 'Z';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(text, style: style),
    );
  }

  getDataForDepartments () async {
    Query allowedForDigital = FirebaseFirestore.instance.collection("requests")
        .where("Department", isEqualTo: "Digital Packing")
        .where("Status", isEqualTo: "ALLOW");
    Query allowedForLocal = FirebaseFirestore.instance.collection("requests")
        .where("Department", isEqualTo: "Local Packing")
        .where("Status", isEqualTo: "ALLOW");
    Query deniedForDigital = FirebaseFirestore.instance.collection("requests")
        .where("Department", isEqualTo: "Digital Packing")
        .where("Status", isEqualTo: "DENY");
    Query deniedForLocal = FirebaseFirestore.instance.collection("requests")
        .where("Department", isEqualTo: "Local Packing")
        .where("Status", isEqualTo: "DENY");



    QuerySnapshot snapAllowedLocal = await allowedForLocal.get();
    List<DocumentSnapshot> docLocalAllowed = snapAllowedLocal.docs;

    QuerySnapshot snapDeniedLocal = await deniedForLocal.get();
    List<DocumentSnapshot> docLocalDenied = snapDeniedLocal.docs;

    QuerySnapshot snapAllowedDigital = await allowedForDigital.get();
    List<DocumentSnapshot> docDigitalAllowed = snapAllowedDigital.docs;

    QuerySnapshot snapDeniedDigital = await deniedForDigital.get();
    List<DocumentSnapshot> docDigitalDenied = snapDeniedDigital.docs;



        setState(() {
          var local = docLocalAllowed.length;
          dispatchLocal = local;

          var digital = docDigitalAllowed.length;
          dispatchDigital = digital;

          numOfErrorsLocal = docLocalDenied.length;
          numOfErrorsDigital = docDigitalDenied.length;

          var numOfSuccess= docDigitalAllowed.length + docLocalAllowed.length;
          totalDispatches = numOfSuccess;

          var numberOfError = docLocalDenied.length + docDigitalDenied.length;
          numOfErrors = numberOfError;


        });

  }



  getDataOfParties() async {
    Query partyA = FirebaseFirestore.instance.collection("requests")
        .where("Party", isEqualTo: "A")
        .where("Status", isEqualTo: "ALLOW");
    Query partyB = FirebaseFirestore.instance.collection("requests")
        .where("Party", isEqualTo: "B")
        .where("Status", isEqualTo: "ALLOW");
    Query partyC = FirebaseFirestore.instance.collection("requests")
        .where("Party", isEqualTo: "C")
        .where("Status", isEqualTo: "ALLOW");
    Query partyX = FirebaseFirestore.instance.collection("requests")
        .where("Party", isEqualTo: "X")
        .where("Status", isEqualTo: "ALLOW");
    Query partyY = FirebaseFirestore.instance.collection("requests")
        .where("Party", isEqualTo: "Y")
        .where("Status", isEqualTo: "ALLOW");
    Query partyZ = FirebaseFirestore.instance.collection("requests")
        .where("Party", isEqualTo: "Z")
        .where("Status", isEqualTo: "ALLOW");

    QuerySnapshot snapA = await partyA.get();
    List<DocumentSnapshot> docA = snapA.docs;

    QuerySnapshot snapB = await partyB.get();
    List<DocumentSnapshot> docB = snapB.docs;

    QuerySnapshot snapC = await partyC.get();
    List<DocumentSnapshot> docC = snapC.docs;

    QuerySnapshot snapX = await partyX.get();
    List<DocumentSnapshot> docX = snapX.docs;

    QuerySnapshot snapY = await partyY.get();
    List<DocumentSnapshot> docY = snapY.docs;

    QuerySnapshot snapZ = await partyZ.get();
    List<DocumentSnapshot> docZ = snapZ.docs;

    setState(() {
      dispatchesA = docA.length;
      dispatchesB = docB.length;
      dispatchesC = docC.length;
      dispatchesX = docX.length;
      dispatchesY = docY.length;
      dispatchesZ = docZ.length;
    });
  }


  AuthService auth = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataForDepartments();
    getDataOfParties();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Reports"),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(15, 46, 94, 10),
            actions:  [
              Tooltip(
                message: "Refresh data",
                child: IconButton(
                    onPressed: () {
                      getDataForDepartments();
                      getDataOfParties();

                    },
                    icon: const Icon(Icons.refresh_rounded)),
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
                          "Owner AB Textiles",
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
                      Navigator.pushNamed(context, Reports.id);
                    },
                    child: const ListTile(
                      selected: true,
                      selectedTileColor: Colors.black,
                      leading: Icon(
                        Icons.data_usage,
                        color: Colors.white,
                      ),
                      title: Text("Reports",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      auth.logout();
                      Navigator.of(context).pushNamedAndRemoveUntil(SignInScreen.id, (route) => false);
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
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Column(
                children:  <Widget>[
                  Row(
                    children: [
                      Expanded(
                          child: Card(
                            
                              child: Container(
                                height: 150,
                                color: Color.fromRGBO(15, 46, 94,15),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text("Dispatches Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Center(
                                        child: Text("$totalDispatches", style: TextStyle(color: Colors.lightGreenAccent, fontWeight: FontWeight.bold, fontSize: 18)),
                                      )
                                    ],
                                  ),
                                ),
                              )
                          )
                      ),
                      Expanded(
                          child: Card(
                              child: Container(
                                height: 150,
                                color: Color.fromRGBO(15, 46, 94,15),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      const Center(
                                        child: Text("Dispatches (Digital Packing)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Center(
                                        child: Text("$dispatchDigital", style: TextStyle(color: Colors.lightGreenAccent, fontWeight: FontWeight.bold, fontSize: 18)),
                                      )
                                    ],
                                  ),
                                ),
                              )
                          )
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Card(
                              child: Container(
                                height: 150,
                                color: Color.fromRGBO(15, 46, 94,15),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      const Center(
                                        child: Text("Dispatches (Local Packing)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Center(
                                        child: Text("$dispatchLocal", style: TextStyle(color: Colors.lightGreenAccent, fontWeight: FontWeight.bold, fontSize: 18)),
                                      )
                                    ],
                                  ),
                                ),
                              )
                          )
                      ),
                      Expanded(
                          child: Card(
                              child: Container(
                                height: 150,
                                color: Color.fromRGBO(15, 46, 94,15),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text("Number of errors (Denied)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Center(
                                        child: Text("$numOfErrors", style: TextStyle(color: Colors.lightGreenAccent, fontWeight: FontWeight.bold, fontSize: 18)),
                                      )
                                    ],
                                  ),
                                ),
                              )
                          )
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  "Num. of Errors per Dept.",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 400,
                child: BarChart(
                    BarChartData(
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: getTitles,
                            ),
                          )
                        ),
                        barGroups:[
                          BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(toY: numOfErrorsLocal!.toDouble(), color: Colors.redAccent)
                              ]
                          ),

                          BarChartGroupData(
                              x: 3,
                              barRods: [
                                BarChartRodData(toY: numOfErrorsDigital!.toDouble(), color: Colors.orangeAccent)
                              ]
                          )
                        ]
                    )

                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Party-wise Dispatches",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Expanded(
                      child: Row(
                        children: const [
                          Icon(Icons.circle, color: Colors.deepPurpleAccent,),
                          SizedBox(width: 5,),
                          Text("Party A"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(Icons.circle, color: Colors.lightBlue,),
                          SizedBox(width: 5,),
                          Text("Party B"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(Icons.circle, color: Colors.lightGreen,),
                          SizedBox(width: 5,),
                          Text("Party C"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(Icons.circle, color: Colors.redAccent,),
                          SizedBox(width: 5,),
                          Text("Party X"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(Icons.circle, color: Colors.orange,),
                          SizedBox(width: 5,),
                          Text("Party Y"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(Icons.circle, color: Colors.tealAccent,),
                          SizedBox(width: 5,),
                          Text("Party Z"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                child: BarChart(
                    BarChartData(
                        titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: getTitlesParty,
                              ),
                            )
                        ),
                        barGroups:[
                          BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(toY: dispatchesA!.toDouble(), color: Colors.deepPurpleAccent)
                              ]
                          ),

                          BarChartGroupData(
                              x: 2,
                              barRods: [
                                BarChartRodData(toY: dispatchesB!.toDouble(), color: Colors.lightBlueAccent)
                              ]
                          ),
                          BarChartGroupData(
                              x: 3,
                              barRods: [
                                BarChartRodData(toY: dispatchesC!.toDouble(), color: Colors.lightGreen)
                              ]
                          ),
                          BarChartGroupData(
                              x: 4,
                              barRods: [
                                BarChartRodData(toY: dispatchesX!.toDouble(), color: Colors.redAccent)
                              ]
                          ),
                          BarChartGroupData(
                              x: 5,
                              barRods: [
                                BarChartRodData(toY: dispatchesY!.toDouble(), color: Colors.orangeAccent)
                              ]
                          ),
                          BarChartGroupData(
                              x: 6,
                              barRods: [
                                BarChartRodData(toY: dispatchesZ!.toDouble(), color: Colors.tealAccent)
                              ]
                          ),
                        ]
                    )

                ),
              )
            ],
          ),
        )
    );
  }
}
