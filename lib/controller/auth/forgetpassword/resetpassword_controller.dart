import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/functions/handlingdatacontroller.dart';
import 'package:mirshop/data/model/auth/forgetpassword/resetpassworddata.dart';

class ResetpasswordController extends GetxController {
  String? email;
  late TextEditingController password;
  late TextEditingController repassword;
  StatusRequest statusRequest = StatusRequest.none;
  ResetpasswordData resetpasswordData = ResetpasswordData(Get.find());
  GlobalKey<FormState> key = GlobalKey<FormState>();
  RxBool isobscureText = true.obs;

  changeicon(){
    isobscureText.value = !isobscureText.value ;
    update();
  }

  postData() async {
    if(key.currentState!.validate()){
     if(password.text == repassword.text){
      statusRequest = StatusRequest.loading;
      update();
      var response = await resetpasswordData.postdata(email!, password.text);
      statusRequest = handlingData(response);
      if(statusRequest == StatusRequest.success){
        if(response['status'] == 'success'){
          Get.offAllNamed('successsignup');
        }
      }
     }else{
      statusRequest = StatusRequest.none;
      return Get.defaultDialog(
       title: "warning", middleText: "Password Doesn't Match");
     }
    }
    update();
  }

  @override
  void onInit() {
    password = TextEditingController();
    repassword = TextEditingController();
    email = Get.arguments['email'];
    super.onInit();
  }
  @override

  void dispose() {
    password.dispose();
    repassword.dispose();
    super.dispose();
  }
}