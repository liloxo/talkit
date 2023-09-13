import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/auth/forgetpassword/checkemail_controller.dart';
import 'package:mirshop/core/class/handlingdataview.dart';
import 'package:mirshop/core/components/textformfield.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/core/functions/validinput.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CheckemailController>(
        init: CheckemailController(),
        builder: (controller) {
        return HandlingDataView(
          statusRequest: controller.statusRequest, 
          widget: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: controller.key,
              child: ListView(
              children: [
               const SizedBox(height: 100),
               const Center(child: Text("Enter you email!",style: TextStyle(fontSize: 20,color: AppColors.black,fontWeight: FontWeight.w400))),
                  const SizedBox(height: 50),
                  CustomTextFormField(
                    mycontroller: controller.email,
                    keyboardType: TextInputType.emailAddress,
                    valid: (val){
                      return validInput(val!, 7, 50, 'email');
                    },
                    labeltext: 'Email',isobscureText: false),
                    TextButton(onPressed: (){controller.postData();}, child: const Text('Check',style: TextStyle(fontSize: 17)))
            ]),
                ),
          ),
          );
      },)
    );
  }
}