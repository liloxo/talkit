import 'package:get/get.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/functions/handlingdatacontroller.dart';
import 'package:mirshop/core/services/services.dart';
import 'package:mirshop/data/model/auth/verifycodedata.dart';

class VerifycodeController extends GetxController {

  String? email;
  VerifycodeData verifycodeData = VerifycodeData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  resendemail()async{
    await verifycodeData.resendData(email!);
  }

  postdata(String verifycode) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await verifycodeData.postdata(email!, verifycode);
    statusRequest = handlingData(response);
    if(statusRequest == StatusRequest.success){
      if(response['status'] == 'success'){
        Get.offAllNamed('successsignup');
      }else {
        Get.defaultDialog(title: "VerifyCode wrong" , middleText: "Try again") ; 
        statusRequest = StatusRequest.none;
      }
    }
    update();
  }

 @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }

}