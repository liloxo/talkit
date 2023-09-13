import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  final void Function() onTapSignin;
  final void Function() onTapgo;
  final String signin;
  final String signgo;
  final String signinfo;
  const CustomBottom({Key? key, required this.onTapSignin, required this.onTapgo, required this.signin, required this.signgo, required this.signinfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40,bottom: 60),
          height: 50,
          width: double.infinity,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xffff5f6d),
                  Color(0xffff5f6d),
                  Color(0xffffc371)
                ]
              )
            ),
            child: InkWell(
              onTap: onTapSignin,
              child: Center(child: Text(signin,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17))),
            )
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(signinfo,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
            GestureDetector(
              onTap: onTapgo,
               child: Text(signgo,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 20))
            )
           ]
        )
      ]
    );
  }
}