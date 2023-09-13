import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/services/services.dart';
import 'package:mirshop/data/model/homepage/home/userinfodata.dart';

class HomepageController extends GetxController {

  String? image;
  late String username;
  late String email;
  MyServices myServices = Get.find();
  late TextEditingController textEditingController ;
  UserinfoData userinfoData = UserinfoData(Get.find());
  late String id;
  // Map info = {};

  getdata() async {
    var response = await userinfoData.postdata(id);
    if(response == StatusRequest.offlinefailure){
     image = null;
    }else{
     image = response['data']['image'];
    }
  //  info.addAll(response['data']);
    update();
  }
 
 @override
  void onInit() {
    id = myServices.sharedPreferences.getString('id')!;
    username = myServices.sharedPreferences.getString('username')!;
    email = myServices.sharedPreferences.getString('email')!;
    textEditingController = TextEditingController();
    getdata();
    super.onInit();
  }
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
 
}