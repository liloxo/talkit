import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/core/constants/colors.dart';

class SuccessSignup extends StatelessWidget {
  const SuccessSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
          SizedBox(height: mediaquery.height * 0.15),
           Center(
            child: Icon(
            Icons.check_circle_outline,
            size: mediaquery.height * 0.25 ,
            color: AppColors.thirdcolor,
          )),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: const Text("congratulations", style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600))),
          const Text("successfully registered", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
          Container(
            decoration: BoxDecoration(
              color: AppColors.thirdcolor,
              borderRadius: BorderRadius.circular(20)
            ),
            margin: EdgeInsets.only(top: mediaquery.height * 0.15,bottom: 30),
            child: MaterialButton(
              onPressed: (){ Get.offAllNamed('login');},
              child: const Text('Go to login', style: TextStyle(fontSize: 17.5,fontWeight: FontWeight.w400,color: AppColors.white)))
          )
        ])
      )
    );
  }
}