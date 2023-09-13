import 'package:flutter/material.dart';
import 'package:mirshop/core/constants/colors.dart';

class CustomBarTextField extends StatelessWidget {
  final Color? color;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const CustomBarTextField({Key? key, this.onChanged, this.controller, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
          controller: controller,
          cursorColor: AppColors.white,
          style: TextStyle(color: AppColors.white,fontSize: 18,fontWeight: FontWeight.w500,decorationColor: color),
          onChanged: onChanged,
          autofocus: true,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
            hintText: 'Search',
          ),
        ),
    );
  }
}