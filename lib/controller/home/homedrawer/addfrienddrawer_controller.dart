import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/functions/handlingdatacontroller.dart';
import 'package:mirshop/core/services/services.dart';
import 'package:mirshop/data/datasource/friends/searchfriendmodel.dart';
import 'package:mirshop/data/model/homepage/drawerdata/addfrienddata/addfrienddata.dart';
import 'package:mirshop/data/model/homepage/drawerdata/addfrienddata/searchfrienddata.dart';

class AddfrienddrawerController extends GetxController {
 
  late TextEditingController textEditingController;
  late String id;
  SearchfriendData searchfriendData = SearchfriendData(Get.find());
  AddfriendData addfriendData = AddfriendData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  bool searchbool = false;
  String value = '';
  List<SearchModel> users = [];
  Timer? debouncee;

  onSearchChanged(String val) {
    if (debouncee?.isActive ?? false) debouncee!.cancel();
    debouncee = Timer(const Duration(milliseconds: 500), () {
      if(val == ''){
       searchbool = false;
      }else{
       searchbool = true;
       value = val;
      }
      update();
    });
  }

  searched(){
    value = '';
    searchbool = false;
    textEditingController.clear();
    statusRequest = StatusRequest.none;
    update();
  }

  Future getdata() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await searchfriendData.postdata(value,id);
    statusRequest = handlingData(response);
    if(statusRequest == StatusRequest.success){
     if(response['status'] == 'success' ){
      users.clear();
      List responselist = response['data'];
      users.addAll(responselist.map((e) => SearchModel.fromJson(e)));
      return users;
     }else{
      statusRequest = StatusRequest.failure;
     }
    }
    update();
  }

  addfriend(String usertwoid)async{
   var response = await addfriendData.postdata(id, usertwoid);
   if(response['status'] == 'failure' ){
    statusRequest = StatusRequest.failure;
   }
   update();
  }

  @override
  void onInit() {
    textEditingController = TextEditingController();
    id = myServices.sharedPreferences.getString('id')!;
    super.onInit();
  }

 @override
  void dispose() {
    textEditingController.dispose();
    debouncee?.cancel();
    super.dispose();
  }
}