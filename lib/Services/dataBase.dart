 import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseMethods{

  Future addRequestDetails(Map<String,dynamic> requestInfoMap,String id)
  async{ 
    return await FirebaseFirestore.instance
    .collection("Request")
    .doc(id)
    .set(requestInfoMap);
  }
    Future <Stream<QuerySnapshot>> getRequestDetails() async{
    return await FirebaseFirestore.instance.collection("Request").snapshots();
  }

   Future updateRequestDetails(Map<String,dynamic> updateInfo,String id)
  async{ 
    return await FirebaseFirestore.instance
    .collection("Request")
    .doc(id)
    .update(updateInfo);
  }

Future deleteRequestDetails(String id) async {
  return await FirebaseFirestore.instance
      .collection("Request")
      .doc(id)
      .delete();
}


}