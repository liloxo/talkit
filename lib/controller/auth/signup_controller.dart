import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/functions/handlingdatacontroller.dart';
import 'package:mirshop/data/model/auth/signupdata.dart';

class SignUpController extends GetxController {

  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController username;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  RxBool isobscureText = true.obs;
  SignupData signupData = SignupData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  changeicon(){
    isobscureText.value = !isobscureText.value ;
    update();
  }

  gotoverifycode() async {
  if (key.currentState!.validate()) {
    statusRequest = StatusRequest.loading; 
    update() ; 
    var response = await signupData.postdata(username.text, email.text, password.text);
    statusRequest = handlingData(response);
    if(statusRequest == StatusRequest.success){
      if(response['status'] == 'success'){
        Get.offNamed('verifycode',arguments: {
          'email': email.text,
        });
      }else {
        Get.defaultDialog(title: "Email Already Exists" , middleText: "Try login instead") ; 
        statusRequest = StatusRequest.none;
      }
    }
    update();
  }
}

  @override
  void onInit() {
    email    = TextEditingController();
    password = TextEditingController();
    username = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    username.dispose();
    username.clear();
    email.dispose();
    password.dispose();
    email.clear();username.clear();password.clear();
    super.dispose();
  }

}