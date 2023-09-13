import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/functions/checkinternet.dart';
import 'package:mirshop/core/functions/handlingdatacontroller.dart';
import 'package:mirshop/core/services/services.dart';
import 'package:mirshop/data/datasource/friends/friendsmodel.dart';
import 'package:mirshop/data/model/homepage/drawerdata/addfrienddata/deletefriend.dart';
import 'package:mirshop/data/model/homepage/drawerdata/addfrienddata/getfriendsdata.dart';

class FriendsdrawerController extends GetxController {

 late String id;
 List<FriendModel> friends = [];
 GetfriendsData getfriendsData = GetfriendsData(Get.find());
 MyServices myServices = Get.find();
 StatusRequest statusRequest = StatusRequest.none;
 DeletefriendData deletefriendData = DeletefriendData(Get.find());
 FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  deletefriend(String friendsid)async{
    var res = await deletefriendData.postdata(friendsid);
    if(res == StatusRequest.offlinefailure){
     internetSnackbar();
    }else{
      await firebaseFirestore.collection('friendsinfo').doc(friendsid).delete();
      final batch = firebaseFirestore.batch();
      var collection = firebaseFirestore.collection('chatroom').doc(friendsid).collection('messages');
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
    update();
  }

  getdata() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await getfriendsData.postdata(id);
    statusRequest = handlingData(response);
    if(statusRequest == StatusRequest.success){
     if(response['status'] == 'success' ){
      friends.clear();
      List friendslist = response['data'];
      friends.addAll(friendslist.map((e) => FriendModel.fromJson(e)));
      return friends;
     }else{
      statusRequest = StatusRequest.failure;
     }
    }
    update();
  }

 @override
  void onInit() {
    id = myServices.sharedPreferences.getString('id')!;
    super.onInit();
  }

}