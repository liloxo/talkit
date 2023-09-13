import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homepage_controller.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/functions/checkinternet.dart';
import 'package:mirshop/core/functions/handlingdatacontroller.dart';
import 'package:mirshop/core/services/services.dart';
import 'package:mirshop/data/datasource/friends/friendslistmodel.dart';
import 'package:mirshop/data/model/homepage/drawerdata/addfrienddata/acceptfrienddata.dart';
import 'package:mirshop/data/model/homepage/drawerdata/addfrienddata/deletefriend.dart';
import 'package:mirshop/data/model/homepage/drawerdata/addfrienddata/friendsrequestslistdata.dart';

class FriendsrequestsController extends GetxController {

  FriendsrequestslistData friendsrequestslistData = FriendsrequestslistData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  late String id;
  late String username;
  MyServices myServices = Get.find();
  List<FriendsListModel> users = [];
  DeletefriendData deletefriendData = DeletefriendData(Get.find());
  AcceptfriendData acceptfriendData = AcceptfriendData(Get.find());
  CollectionReference<Map<String, dynamic>> firebaseFirestore = FirebaseFirestore.instance.collection('friendsinfo');
  HomepageController homepageController = Get.put(HomepageController());

  deletefriend(String friendid)async{
    await deletefriendData.postdata(friendid);
    update();
  }

  acceptfriend(String friendsid,String useroneid,String useroneusername,String? useroneimage) async {
    var res = await acceptfriendData.postdata(friendsid);
      if(res == StatusRequest.offlinefailure){
       internetSnackbar();
      }else{
      await firebaseFirestore.doc(friendsid).set({
      'roomemail' : [useroneid,id],
      'sender'    : null,
      'friendsid' : friendsid,
      'useroneid'  : useroneid,
      'useroneusername'  : useroneusername,
      'useroneimage' : useroneimage,
      'usertwoid'    : id,
      'usertwousername'    : username,
      'usertwoimage'    : homepageController.image,
      'text'      : 'Send first message',
      'time'      : null,
      'view'      : null
    });
    update();
    }
  } 

  getrequestslist() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await friendsrequestslistData.postdata(id);
    statusRequest = handlingData(response);
    if(statusRequest == StatusRequest.success){
     if(response['status'] == 'success' ){
      users.clear();
      List newlist = response['data'];
      users.addAll(newlist.map((e) => FriendsListModel.fromJson(e)));
      return users;
     }else{
      statusRequest = StatusRequest.failure;
     }
    }
    update();
  }

  @override
  void onInit() {
    id = myServices.sharedPreferences.getString('id')!;
    username = myServices.sharedPreferences.getString('username')!;
    super.onInit();
  }

}