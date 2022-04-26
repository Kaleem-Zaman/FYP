import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/backend%20services/auth_class.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:motion_toast/resources/constants.dart';

class ShowRequestDetailWidget extends StatelessWidget {
  AuthDispatch authDispatch = new AuthDispatch();
  bool? isConfirm = false;
  dynamic poNum, party, length, quality, status, id;
  ShowRequestDetailWidget(
      {Key? key,
      required this.poNum,
      required this.party,
      required this.length,
      required this.quality,
      required this.status,
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
        height: 320,
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
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                      style: TextStyle(fontSize: 15, color: Colors.white),
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


                      List requestInfo = await authDispatch.updateRequestStatus(id, "DENY");
                      if (requestInfo[0].exists) {
                        await requestInfo[1].update(requestInfo[2]);
                        MotionToast.delete(
                          description:
                          Text("Status has been set to: DENY"),
                          borderRadius: 5,
                          title: Text("Status Update"),
                          onClose: () => Navigator.pop(context),
                        ).show(context);
                      } else {
                        MotionToast.error(
                          description: const Text(
                              "Some error occurred while updating the status! Please check you are connected to the internet and try again!"),
                          borderRadius: 5,
                          title: Text("Status Update"),
                          onClose: () => Navigator.pop(context),
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


                    // this list packs up snap, document ref, and new map returned from the function
                    List info = await authDispatch.updateRequestStatus(id, "ALLOW");
                    //here we access those values through indexing the list
                    if (info[0].exists) {
                      await info[1].update(info[2]);
                      
                      MotionToast.success(
                        description: Text("Status has been set to: ALLOW"),
                        borderRadius: 5,
                        title: Text("Status Update"),
                        toastDuration: const Duration(seconds: 5),
                        onClose: () => Navigator.pop(context),
                      ).show(context);
                      
                    } else {
                      MotionToast.error(
                        description: const Text(
                            "Some error occurred while updating the status! Please check you are connected to the internet and try again!"),
                        borderRadius: 5,
                        title: Text("Status Update"),
                        onClose: () => Navigator.pop(context),  
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
