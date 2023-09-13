 import 'package:cloud_firestore/cloud_firestore.dart';

  tokenremoorset(bool isset,String path,String token)async{
    CollectionReference<Map<String, dynamic>> doc1 = FirebaseFirestore.instance.collection('tokens');
    DocumentSnapshot<Map<String, dynamic>>? doc2 = await doc1.doc(path).get();
    List? info = doc2.data()?['token'];
    if(info == null){
      await doc1.doc(path).set({'token':[token]});
    }else{
      isset ? info.remove(token) : info.add(token) ;
      await doc1.doc(path).delete();
      await doc1.doc(path).set({'token':info});
    }
  }