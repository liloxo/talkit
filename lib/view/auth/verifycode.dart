import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/auth/verifycode_controller.dart';
import 'package:mirshop/core/class/handlingdataview.dart';
import 'package:mirshop/core/constants/colors.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(VerifycodeController());
    Size mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<VerifycodeController>(builder: (controller){
        return HandlingDataView(
          statusRequest: controller.statusRequest, 
          widget: SingleChildScrollView(
          child: Column(
           children: [
            SizedBox(height: mediaquery.height * 0.2),
            Center(child: Column(
              children:  [
                 const Text("We have sent a verification code to ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                 Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 80),
                  child: Text(controller.email!,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: AppColors.primaryColor)),
                )
              ]
            )),
            Center(
              child: OtpTextField(
              margin: const EdgeInsets.only(bottom: 25,right: 10,left: 10),
              numberOfFields: 5,
              borderColor: AppColors.primaryColor,
              showFieldAsBox: true, 
              onSubmit: (String verificationCode){
                controller.postdata(verificationCode);
              } 
            )
            ),
            TextButton(onPressed: (){controller.resendemail();}, child: const Text('Resend Email',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)))
          ]
        )
       )
      );
      })
    );
  }
}