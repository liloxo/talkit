import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homedrawer/homedrawer_controller.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/view/widget/drawerwidget/imagedecoration.dart';

class CustomImageContainer extends StatelessWidget {
  final String? image;
  const CustomImageContainer({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return GetBuilder<HomedrawerController>(
      init: HomedrawerController(),
      builder: (controller){
      return Container(
       padding: const EdgeInsets.only(left: 20),
       height: mediaquery.height * 0.22,
       color: AppColors.thirdcolor,
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        InkWell(
         onTap: () {controller.pickimage();},
         child: Padding(
           padding: EdgeInsets.only(bottom: 15, top: mediaquery.height * 0.04),
           child: ImageDecoration(icon: Icons.add_a_photo_rounded,username: controller.homepageController.username,image: image),
         )
        ),
       Text('   ${controller.homepageController.username}',style: const TextStyle(color: AppColors.white,fontSize: 20,fontWeight: FontWeight.w600))
       ])
      );
    });
  }
}