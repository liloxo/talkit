import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/functions/handlingdatacontroller.dart';
import 'package:mirshop/data/model/auth/forgetpassword/checkemaildata.dart';

class CheckemailController extends GetxController {
  late TextEditingController email;
  StatusRequest statusRequest = StatusRequest.none;
  CheckemailData checkemailData = CheckemailData(Get.find());
  GlobalKey<FormState> key = GlobalKey<FormState>();

  postData() async {
    if(key.currentState!.validate()){
     statusRequest = StatusRequest.loading;
     update();
     var response = await checkemailData.postdata(email.text);
     statusRequest = handlingData(response);
     if(statusRequest == StatusRequest.success){
       if(response['status'] == 'success'){
        Get.toNamed('verifycodeemail',arguments: {'email':email.text});
       }else {
          Get.defaultDialog(title: "ُWarning" , middleText: "Email Not Found"); 
          statusRequest = StatusRequest.none;
        }
     }
    }
    update();
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}