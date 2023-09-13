import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homedrawer/homedrawer_controller.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/view/widget/drawerwidget/customlisttiledrawer.dart';
import 'package:mirshop/view/widget/drawerwidget/imagedecoration.dart';

class ProfileWidget extends StatelessWidget {
  //final UserModel userModel;
  final String? image;
  const ProfileWidget({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomedrawerController controller = Get.put(HomedrawerController());
    Size mediaquery = MediaQuery.of(context).size;
    return CustomListTileDrawer(
      icon: Icons.person, 
      text: 'Profile', 
      onTap: () {
      Get.defaultDialog(
      backgroundColor: AppColors.white,title: '',
      content: SizedBox(
      height: mediaquery.height * 0.45,
      width: mediaquery.width * 0.7,
      child: Column(
        children: [
          SizedBox(
            height: mediaquery.height * 0.13,
            width: mediaquery.width * 0.65,
            child: Card(
              color: AppColors.secondaryColor,
              child: Row(
                children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ImageDecoration(image: image,username: controller.homepageController.username),
                ),
                Text(controller.homepageController.username,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: AppColors.white))
              ])
            )
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: mediaquery.height * 0.11,
            width: mediaquery.width * 0.65,
            child: Card(
              color: Colors.white,
              child: Row(
                  children: [
                 Container(
                  margin: const EdgeInsets.all(5),
                  child: const Icon(Icons.email,color: AppColors.thirdcolor)),
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.only(right: 10),
                     child: Wrap(
                      direction: Axis.vertical,
                      children: [
                       const Text('Email',style: TextStyle(fontSize: 17.5,fontWeight: FontWeight.w500,color: AppColors.grey)),
                       Text(controller.homepageController.email,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: AppColors.black),maxLines: 2)
                     ])
                   )
                 )
                ])
            )
          ),
          SizedBox(
            height: mediaquery.height * 0.11,
            width: mediaquery.width * 0.65,
            child: Card(
              color: Colors.white,
              child: Row(
                  children: [
                 Container(
                  margin: const EdgeInsets.all(5),
                  child: const Icon(Icons.person,color: AppColors.thirdcolor)),
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.only(top: 8,right: 10),
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       const Text('Username',style: TextStyle(fontSize: 17.5,fontWeight: FontWeight.w500,color: AppColors.grey)),
                       Text(controller.homepageController.username,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: AppColors.black),maxLines: 2)
                     ])
                   )
                 )
                ])
            )
          )
        ]
      )
    )
        );}
    );
  }
}