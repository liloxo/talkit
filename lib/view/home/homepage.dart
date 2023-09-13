import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homepage_controller.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/view/home/homedrawer/drawerpage.dart';
import 'package:mirshop/view/home/homemessages/homemessages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return GetBuilder<HomepageController>(
      init: HomepageController(),
      builder: (controller){
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: mediaquery.height * 0.1,
          elevation: 0,
          backgroundColor: AppColors.thirdcolor,
          title: const Text('Talkit',style: TextStyle(letterSpacing: 2,fontSize: 25,fontWeight: FontWeight.w500))
        ),
        backgroundColor: AppColors.thirdcolor,
        drawer: const HomeDrawer(),
        body: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(27))
          ),
          child: Column(
            children: const [ 
              Expanded(
                child: HomeMessages(),
              )
            ]
          )
        )
      );
    });
  }
}