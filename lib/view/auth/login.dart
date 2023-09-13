import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/auth/login_controller.dart';
import 'package:mirshop/core/class/handlingdataview.dart';
import 'package:mirshop/core/components/textformfield.dart';
import 'package:mirshop/core/functions/validinput.dart';
import 'package:mirshop/view/widget/authwidget/custombottom.dart';
import 'package:mirshop/view/widget/authwidget/customcontinue.dart';

class Login extends StatelessWidget{
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: GetBuilder<LoginController>(builder: (controller){
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
                  mycontroller: controller.email,
                  keyboardType: TextInputType.emailAddress,
                  valid: (val){
                    return validInput(val!, 7, 50, 'email');
                  },
                  labeltext: 'Email',isobscureText: false),
                CustomTextFormField(
                  mycontroller: controller.password,
                  valid: (val){
                  return validInput(val!, 5, 50, 'password');
                  },
                  labeltext: 'Password',isobscureText: controller.isobscureText.value,
                  suffixIcon: IconButton(onPressed: (){
                  controller.changeicon();
                 }, icon: const Icon( Icons.visibility ))
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: (){Get.toNamed('checkemail');},
                    child: const Text("Forgot Password ?",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600))),
                ),
                CustomBottom(
                 onTapSignin: () {controller.gotoHome();}, 
                 onTapgo: () {Get.offAllNamed('signup');}, 
                 signgo: ' Sign up', signin: 'LogIn', signinfo: "Don't have an account ?",
                )
              ]
            ),
          )
        )
      )
          );
      })
    );
  }
}