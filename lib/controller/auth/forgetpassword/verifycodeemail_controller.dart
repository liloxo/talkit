import 'package:get/get.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/functions/handlingdatacontroller.dart';
import 'package:mirshop/data/model/auth/forgetpassword/verifycodeemail.dart';
import 'package:mirshop/data/model/auth/verifycodedata.dart';

class VerifycodeemailController extends GetxController {

  String? email;
  StatusRequest statusRequest = StatusRequest.none;
  VerifycodeData verifycodeData = VerifycodeData(Get.find());
  VerifycodeemailData verifycodeemailData = VerifycodeemailData(Get.find());

  resendemail()async{
    await verifycodeData.resendData(email!);
  }

  postData(String verifycode) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await verifycodeemailData.postdata(email!, verifycode);
    statusRequest = handlingData(response);
    if(statusRequest == StatusRequest.success){
     if(response['status'] == 'success'){
      Get.offNamed('resetpassword',arguments: {'email':email});
     }else{
      Get.defaultDialog(title: "VerifyCode wrong" , middleText: "Try again") ; 
      statusRequest = StatusRequest.none;
     }
    }
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }

}