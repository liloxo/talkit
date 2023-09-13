import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/auth/signup_controller.dart';
import 'package:mirshop/core/class/handlingdataview.dart';
import 'package:mirshop/core/components/textformfield.dart';
import 'package:mirshop/core/functions/alertexitapp.dart';
import 'package:mirshop/core/functions/validinput.dart';
import 'package:mirshop/view/widget/authwidget/custombottom.dart';
import 'package:mirshop/view/widget/authwidget/customcontinue.dart';

class SignUp extends StatelessWidget{
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<SignUpController>(builder: (controller){
          return HandlingDataView(
            statusRequest: controller.statusRequest, 
            widget: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const CustomContinue(),
              const SizedBox(height: 50),
              CustomTextFormField(
                mycontroller: controller.username,
                valid: (val) {
                  return validInput(val!, 4, 15, 'username');
                },
                isobscureText: false, labeltext: 'Username'
                ),
              CustomTextFormField(
                mycontroller: controller.email,
                keyboardType: TextInputType.emailAddress,
                valid: (val){
                  return validInput(val!, 7, 50, 'email');
                },
                labeltext: 'Email',
                isobscureText: false
                ),
              CustomTextFormField(
                  mycontroller: controller.password,
                  valid: (val){
                  return validInput(val!, 5, 50, 'password');
                 },
                 labeltext: 'Password',isobscureText: controller.isobscureText.value,
                 suffixIcon: IconButton(onPressed: (){
                 controller.changeicon();
               }, icon: const Icon( Icons.visibility )),
              ),
              CustomBottom(
                onTapSignin: () {controller.gotoverifycode();}, 
                onTapgo: () {Get.offAllNamed('login');}, 
                signgo: ' Login', signin: 'SignUp', signinfo: 'Already have an account ?',
              )
            ]
          )
          )
        )
      )
            );
        })
        )
    );
  }
}