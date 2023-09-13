import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? mycontroller;
  final bool isobscureText;
  final TextInputType? keyboardType;
  final String? hintText;
  final String labeltext;
  final Widget? prefixIcon;
  final String? Function(String?)? valid;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  const CustomTextFormField({super.key, 
         this.mycontroller, 
         required this.isobscureText, 
         this.keyboardType, 
         this.hintText, 
         required this.labeltext, 
         this.prefixIcon, 
         this.valid, this.suffixIcon, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: TextFormField(
        controller: mycontroller,
        validator: valid,
        onChanged: onChanged ,
        obscureText: isobscureText,
        keyboardType: keyboardType,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          focusColor: Colors.red,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 2.2,
              color: Colors.red
            )
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          label: Text(labeltext,style: const TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.w500)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          prefixIcon: prefixIcon,
          prefixIconColor: Colors.red,
          suffixIcon: suffixIcon,
          suffixIconColor: isobscureText ? Colors.grey : Colors.red,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))        
        ),
      ),
    );
  }
}