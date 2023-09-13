import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mirshop/controller/home/homepage_controller.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/core/functions/checkinternet.dart';
import 'package:mirshop/core/functions/tokensetandremove.dart';
import 'package:mirshop/core/services/services.dart';
import 'package:mirshop/data/model/homepage/drawerdata/addfrienddata/friendsrequests.dart';
import 'package:mirshop/data/model/homepage/drawerdata/imagesdata/deleteimagedata.dart';
import 'package:mirshop/data/model/homepage/drawerdata/imagesdata/uploadimagedata.dart';
import 'package:mirshop/data/model/homepage/home/userinfodata.dart';

class HomedrawerController extends GetxController {

  MyServices myServices = Get.find();
  File? myfile;
  late String id;
  UploadimageData uploadimageData = UploadimageData(Get.find());
  DeleteimageData deleteimageData = DeleteimageData(Get.find());
  HomepageController homepageController = Get.put(HomepageController());
  FriendsrequestsData friendsrequestsData = FriendsrequestsData(Get.find());
  bool isrequest = false;
  String? token;
  CollectionReference<Map<String, dynamic>> firebasefirestore= FirebaseFirestore.instance.collection('friendsinfo');
  UserinfoData userinfoData = UserinfoData(Get.find());
  String? otherimage;

  imagevalue(String key )  {
    String? fieldkey;
    if(id == key){
      fieldkey = 'useroneimage';
    }else{
      fieldkey = 'usertwoimage';
    }
    return fieldkey;
  }

  updatefirestoreimage(String? imagepath)async{
    QuerySnapshot<Map<String, dynamic>> res = await firebasefirestore.where('roomemail',arrayContains: id).get();
    if(res.docs.isNotEmpty){
      for (var element in res.docs) {
       await firebasefirestore.doc(element.id).update({
       imagevalue(element.data()['useroneid']) : imagepath
       });
      }
    }else {
      null;
    }
  }

  getrequests() async {
    var response = await friendsrequestsData.postdata(id);
    if(response == StatusRequest.offlinefailure){
     isrequest = false;
    }
    else if(response['status'] == 'success'){
     isrequest = true;
    }else{
     isrequest = false;
    }
    update();
  }

  deleteimage()async{
    var res = await deleteimageData.postdata(id, homepageController.image!);
    if(res == StatusRequest.offlinefailure){
      internetSnackbar();
    }else{
      homepageController.getdata();
      update();
      Get.back();
    }
  }

  sourceimage(ImageSource source)async{
    XFile? xFile = await ImagePicker().pickImage(source: source);
    if(xFile != null){
     myfile = File(xFile.path);
     var res = await uploadimageData.postdata(id, myfile);
     if(res == StatusRequest.offlinefailure){
      internetSnackbar();
     }else{
     //homepageController.getdata();
     var response = await userinfoData.postdata(id);
    if(response == StatusRequest.offlinefailure){
     otherimage = null;
    }else{
     otherimage = response['data']['image'];
    }
     updatefirestoreimage(otherimage);
     update();
     Get.back();
     }
    }
  }
  
  pickimage()async{
    Get.defaultDialog(
      title: 'Choose from',
      backgroundColor: AppColors.white,
      content: 
    Container(
      padding: const EdgeInsets.only(left: 15),
      height: homepageController.image == '' ? 100 : 130,
      child: Column(
        children: [
          InkWell(
            onTap: () async {sourceimage(ImageSource.camera);},
            child: Row(
              children: const[
                Icon(Icons.camera_alt),
                Text('   From Camera',style: TextStyle(fontSize:20,fontWeight: FontWeight.w500 ,color: AppColors.primaryColor)),
              ]
            )
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: InkWell(
              onTap: (){sourceimage(ImageSource.gallery);},
              child: Row(
                children: const[
                  Icon(Icons.photo_sharp),
                  Text('   From Gallery',style: TextStyle(fontSize:20,fontWeight: FontWeight.w500,color: AppColors.primaryColor )),
                ]
              )
            ),
          ),
          homepageController.image == '' 
          ? const SizedBox()
          : InkWell(
            onTap: () {deleteimage();},
            child: Row(
              children: const[
                Icon(Icons.hide_image),
                Text('   Delete Image',style: TextStyle(fontSize:20,fontWeight: FontWeight.w500,color: AppColors.primaryColor )),
              ]
            )
          )
        ]
      )
    ));
  }

  logout() async {
    Get.offAllNamed('signup');
    tokenremoorset(true, id, token!);
    myServices.sharedPreferences.clear();
  }
 
 @override
  void onInit() {
    id = myServices.sharedPreferences.getString('id').toString();
    token = myServices.sharedPreferences.getString('token');
    getrequests();
    super.onInit();
  }
}