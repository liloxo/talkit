import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homemessages/homemessages_controller.dart';
import 'package:mirshop/view/widget/drawerwidget/imagedecoration.dart';

class HomemessageCard extends StatelessWidget {
  final String username;
  final String? image;
  final Widget lastmessage;
  final Widget? messagetime;
  const HomemessageCard({Key? key, required this.username, this.image, required this.lastmessage, this.messagetime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return GetBuilder<HomemessagesController>(
      init: HomemessagesController(),
      builder: (controller){
      return SizedBox(
        height: mediaquery.height * 0.14,
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
            Row(
              children: [
              Container(
              width: mediaquery.width * 0.25,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: ImageDecoration(image: image,username: username,icon: null)
              ),
              SizedBox(
                width: mediaquery.width * 0.5,
                child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                  Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(username,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),maxLines: 1)
                  ),
                 Container(
                   margin: const EdgeInsets.symmetric(vertical: 5),
                   child: lastmessage
                 )
                ]),
              )
              ]),
            Container(
              alignment: Alignment.centerRight,
              width: mediaquery.width * 0.25,
              padding: EdgeInsets.only(right: 7,top: mediaquery.height * 0.045),
              child: messagetime
            )
          ])
        )
      );
    });
  }
}

