import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/core/constants/colors.dart';

checkInternet() async {
  try {
    var result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  }on SocketException catch (_) {
    return false;
  }
}

internetSnackbar(){
  Get.rawSnackbar(
    icon: const Icon(Icons.wifi_off),
    message: 'Check your internet connection',backgroundColor: AppColors.grey);
}