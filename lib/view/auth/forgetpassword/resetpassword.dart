import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/auth/forgetpassword/resetpassword_controller.dart';
import 'package:mirshop/core/class/handlingdataview.dart';
import 'package:mirshop/core/components/textformfield.dart';
import 'package:mirshop/core/functions/validinput.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ResetpasswordController>(
        init: ResetpasswordController(),
        builder: (controller){
        return HandlingDataView(
          statusRequest: controller.statusRequest, 
          widget: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: controller.key,
              child: ListView(
                children: [
                  const SizedBox(height: 100),
                  CustomTextFormField(
                    mycontroller: controller.password,
                    valid: (val){
                    return validInput(val!, 5, 50, 'password');
                    },
                    labeltext: 'Enter New Password',isobscureText: controller.isobscureText.value,
                    suffixIcon: IconButton(onPressed: (){
                    controller.changeicon();
                   }, icon: const Icon( Icons.visibility ))
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical:25),
                    child: CustomTextFormField(
                      mycontroller: controller.repassword,
                      valid: (val){
                      return validInput(val!, 5, 50, 'password');
                      },
                      labeltext: 'Enter New Password Again',isobscureText: controller.isobscureText.value,
                      suffixIcon: IconButton(onPressed: (){
                      controller.changeicon();
                     }, icon: const Icon( Icons.visibility ))
                    ),
                  ),
                  TextButton(onPressed: (){controller.postData();}, child: const Text('Reset Password',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)))
                ],
              )
              ),
          )
          );
      }),
    );
  }
}