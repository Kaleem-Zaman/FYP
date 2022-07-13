import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/backend%20services/auth_class.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:get/get.dart';
import 'package:motion_toast/resources/arrays.dart';

class ShowRequestDetailWidget extends StatelessWidget {

  AuthDispatch authDispatch = new AuthDispatch();
  bool? isConfirm = false;
  dynamic poNum,
      party,
      length,
      quality,
      status,
      amount,
      customerStatus,
      paymentPercentage,
      id;
  ShowRequestDetailWidget(
      {Key? key,
      required this.poNum,
      required this.party,
      required this.length,
      required this.quality,
      required this.status,
      required this.amount,
      required this.paymentPercentage,
      required this.customerStatus,
      required this.id})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(15, 46, 94, 50),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(15, 46, 94, 100),
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                  offset: Offset(2.0, 7.0))
            ]),
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(10),
        height: 500,
        child: Column(
          children: [
            Table(
              border: TableBorder.all(color: Colors.white),
              children: [
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
                      "$poNum",
                      style: TextStyle(fontSize: 17, color: Colors.white),
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
                      "$party",
                      style: TextStyle(fontSize: 17, color: Colors.white),
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
                      style: TextStyle(fontSize: 17, color: Colors.white),
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
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  )
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Customer Status",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "$customerStatus",
                      style: TextStyle(fontSize: 17, color: Colors.greenAccent),
                    ),
                  )
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Amount(%age)",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "$amount",
                          style: TextStyle(fontSize: 17)
                        ),
                        TextSpan(
                          text: " ($paymentPercentage%)",
                          style: TextStyle(color: Colors.yellowAccent, fontSize: 15)
                        )
                      ]),

                    ),
                  )
                ]),
                TableRow(children: [
                  const Padding(
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
                      style: TextStyle(fontSize: 17, color: Colors.redAccent),
                    ),
                  )
                ]),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [


                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  height: 45,
                  decoration:  const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.elliptical(20, 20), bottomRight: Radius.elliptical(20,20)),
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(13, 48, 10, 1),
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                          offset: Offset(2.0, 7.0)
                      )
                    ]
                  ),
                  child: ElevatedButton(

                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith((states) => 0),
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.green)
                    ),
                    onPressed: () async {
                      //this list packs up snap, document ref, and new map returned from the function
                      List info =
                          await authDispatch.updateRequestStatus(id, "ALLOW");
                      //here we access those values through indexing the list
                      if (info[0].exists) {
                        await info[1].update(info[2]);

                        MotionToast.success(
                          description: Text("Status has been set to: ALLOW"),
                          borderRadius: 5,
                          title: Text("Status Update"),
                          position: MOTION_TOAST_POSITION.top,
                          animationType: ANIMATION.fromTop,
                          toastDuration: const Duration(seconds: 5),
                          onClose: () => Navigator.pop(context),
                        ).show(context);
                      } else {
                        MotionToast.error(
                          description: const Text(
                              "Some error occurred while updating the status! Please check you are connected to the internet and try again!"),
                          borderRadius: 5,
                          title: Text("Status Update"),
                          position: MOTION_TOAST_POSITION.top,
                          onClose: () => Navigator.pop(context),
                        ).show(context);
                      }

                    },
                    child: Text(
                      "ALLOW",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  height: 45,
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(topLeft: Radius.elliptical(20, 20), bottomRight: Radius.elliptical(20,20)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(51, 11, 11, 1),
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                            offset: Offset(2.0, 7.0)
                        )
                      ]
                  ),
                  child: ElevatedButton(

                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                      elevation: MaterialStateProperty.resolveWith((states) => 0)
                    ),
                    onPressed: () async {
                      List requestInfo =
                      await authDispatch.updateRequestStatus(id, "DENY");
                      if (requestInfo[0].exists) {
                        await requestInfo[1].update(requestInfo[2]);
                        MotionToast.delete(
                          description: Text("Status has been set to: DENY"),
                          borderRadius: 5,
                          title: Text("Status Update"),
                          position: MOTION_TOAST_POSITION.top,
                          animationType: ANIMATION.fromTop,
                          onClose: () => Navigator.pop(context),
                        ).show(context);
                      } else {
                        MotionToast.error(
                          description: const Text(
                              "Some error occurred while updating the status! Please check you are connected to the internet and try again!"),
                          borderRadius: 5,
                          title: Text("Status Update"),
                          position: MOTION_TOAST_POSITION.top,
                          onClose: () => Navigator.pop(context),
                        ).show(context);
                      }


                    },
                    child: Text(
                      "DENY",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
