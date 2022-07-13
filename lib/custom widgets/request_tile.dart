import 'package:flutter/material.dart';
import 'package:fyp/screens/request_details.dart';
import 'package:status_alert/status_alert.dart';

class RequestTile extends StatelessWidget {
  String po_number;
  String party_name,
      length,
      quality,
      status,
      amount,
      customerStatus,
      paymentPercentage,
      id;
  RequestTile(
      {Key? key,
      required this.po_number,
      required this.party_name,
      required this.quality,
      required this.length,
      required this.status,
      required this.amount,
      required this.customerStatus,
      required this.paymentPercentage,
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
          boxShadow: const [
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
                  const TextSpan(
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
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: "Party:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: " $party_name",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
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
                            amount: amount,
                            customerStatus: customerStatus,
                            paymentPercentage: paymentPercentage,
                            id: id,
                          )));
            },
            child: Row(
              children: const [
                Text("Details "),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                ),
              ],
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(106, 125, 155, 10))),
          ),
        ],
      ),
    );
  }
}
