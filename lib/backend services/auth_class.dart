import 'package:cloud_firestore/cloud_firestore.dart';
class AuthDispatch {
  dynamic updateRequestStatus (requestId, status) async
  {
    DocumentReference docref = FirebaseFirestore.instance
        .collection("requests")
        .doc("$requestId");
    Map<String, dynamic> docMap = ({
      "Status": "$status",
    });
    DocumentSnapshot snap = await docref.get();
    return [snap, docref, docMap];
  }


}
