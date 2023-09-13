import 'package:flutter/material.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/constants/colors.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(
            child: CircularProgressIndicator(color: AppColors.thirdcolor))
        : statusRequest == StatusRequest.offlinefailure
            ? const Center(
                child: Text('Offline',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)))
            : statusRequest == StatusRequest.serverfailure
                ? const Center(
                    child: Text('Error',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)))
                : statusRequest == StatusRequest.failure
                    ? const Center(
                        child: Text('No results',style: TextStyle(color: AppColors.grey,fontSize: 17.5)))
                    : widget;
  }
}