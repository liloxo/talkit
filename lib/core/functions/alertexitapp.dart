import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/core/constants/colors.dart';
Future<bool> alertExitApp() {
  Get.defaultDialog(
      title: "Warning",
      titleStyle:const  TextStyle(color: AppColors.primaryColor , fontWeight: FontWeight.bold),
      middleText: "Are you sure you want to exit this app",
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primaryColor)),
            onPressed: () {
              exit(0);
            },
            child:const Text("Confirm")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primaryColor)),
            onPressed: () {
              Get.back();
            },
            child:const Text("Cancel"))
      ]);
  return Future.value(true);
}