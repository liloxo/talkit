import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homemessages/homemessages_controller.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/linkapi.dart';

class ImageDecoration extends StatelessWidget {
  final String? image;
  final String? username;
  final IconData? icon;
  const ImageDecoration({Key? key, this.image, this.username, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomemessagesController());
    Size mediaquery = MediaQuery.of(context).size;
    return GetBuilder<HomemessagesController>(
      builder: (controller){
      return Container(
        height: mediaquery.height * 0.1,
        width: mediaquery.width * 0.2,
        decoration: BoxDecoration(
           shape: BoxShape.circle,
           image: controller.iscon == true 
           ?
            image == null
             ? null
             : DecorationImage(
               image: NetworkImage("${LinkApi.linkServerImages}/$image"),
               fit: BoxFit.cover,
             )
            : null ,
             color: AppColors.white,
           ),
         child: Stack(
           children: [
             if (image == null)
              Center(
                child: Text(username!.substring(0,1).toUpperCase(),style: const TextStyle(color: AppColors.primaryColor,fontSize: 25,fontWeight: FontWeight.w500))
              ),
              icon == null 
              ? const SizedBox()
              : Positioned(
               bottom: 0,
               right: 0,
               child: Container(
                 padding: const EdgeInsets.all(4),
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   color: Colors.grey.withOpacity(0.7),
                 ),
                 child: Icon(icon,size: 18,color: Colors.white)
               )
             )
           ]
          )
        );
    });
  }
}