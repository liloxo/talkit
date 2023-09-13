import 'package:flutter/material.dart';

class CustomContinue extends StatelessWidget {
  const CustomContinue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: mediaquery.height *0.15,bottom: 6),
          child: const Text("Welcome,",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold)),
        ),
        Text("Sign in to continue!",style: TextStyle(fontSize: 20,color: Colors.grey.shade400))
      ]
    );
  }
}