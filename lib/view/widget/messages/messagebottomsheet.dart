 import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/core/constants/colors.dart';

 whenpressedlong(String message,void Function()? onTap,bool isdelete){
   Get.bottomSheet(
    SizedBox(
    height: 60,
    child: Row(
      mainAxisAlignment: isdelete ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
      children: [
      isdelete ? inkitem(onTap,Icons.delete_outline,'Delete') : const SizedBox(),
      inkitem((){FlutterClipboard.copy(message).then((value) => Get.back());},Icons.copy,'Copy')
    ])
    ),
    backgroundColor: AppColors.white,
    );
}

 inkitem(void Function()? onTap,IconData? icon,String? data){
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Icon(icon),
      Text(data!)
      ]
    )
  );
}