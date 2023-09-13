import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/functions/handlingdatacontroller.dart';
import 'package:mirshop/core/functions/tokensetandremove.dart';
import 'package:mirshop/core/services/services.dart';
import 'package:mirshop/data/model/auth/logindata.dart';
import 'package:mirshop/data/model/auth/verifycodedata.dart';

class LoginController extends GetxController {

  MyServices myServices = Get.find();
  late TextEditingController email;
  late TextEditingController password;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  RxBool isobscureText = true.obs;
  bool isloading = false;
  LoginData loginData = LoginData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  VerifycodeData verifycodeData = VerifycodeData(Get.find());
  CollectionReference<Map<String, dynamic>> firebaseFirestore = FirebaseFirestore.instance.collection('tokens');
  FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  String? pushToken;
  bool isserver = false;

  Future<void> getFirebaseMessagingToken() async {
    pushToken = await fMessaging.getToken();
    if(pushToken == null){
     isserver = true;
     update();
    }
  }

  changeicon(){
    isobscureText.value = !isobscureText.value ;
    update();
  }

  gotoHome() async {
   if(key.currentState!.validate()){
    if(isserver == true){
     Get.defaultDialog(title: 'Server not working',content: const Text('Try again later'));
   }else{
    statusRequest = StatusRequest.loading;
    update();
    var response = await loginData.postdata(email.text, password.text);
    statusRequest = handlingData(response);
    if(statusRequest == StatusRequest.success){
      if(response['status'] == 'success'){
        if(response['data']['approve'] == 1){
          myServices.sharedPreferences.setString('signed', '1');
          myServices.sharedPreferences.setString('id', response['data']['id'].toString());
          Get.offAllNamed('homepage');
          myServices.sharedPreferences.setString('username', response['data']['username']);
          myServices.sharedPreferences.setString('email', response['data']['email']);
          myServices.sharedPreferences.setString('token', pushToken!);
          tokenremoorset(false, response['data']['id'].toString(), pushToken!);
        }else{
          Get.toNamed('verifycode',arguments: {"email": email.text});
          await verifycodeData.resendData(email.text);
          //Get.defaultDialog(title: "Email isn't verified" , middleText: "Try again") ; 
          statusRequest = StatusRequest.none;
        }
      }else{
        Get.defaultDialog(title: "Email or Password is wrong" , middleText: "Try again") ; 
        statusRequest = StatusRequest.none;
      }
    }
   }
    update();
   }
  }

  @override
  void onInit() {
    email    = TextEditingController();
    password = TextEditingController();
    getFirebaseMessagingToken();
    super.onInit();
  }
  
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}