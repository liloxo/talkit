import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homemessages/homemessages_controller.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/view/home/homemessages/homemessagescard.dart';

class HomeMessages extends StatelessWidget {
  const HomeMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomemessagesController>(
      init: HomemessagesController(),
      builder: (controller){
      return StreamBuilder<QuerySnapshot<Map<dynamic, dynamic>>>(
        stream: controller.source(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>> snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColors.thirdcolor));
        } 
        if (snapshot.data != null && snapshot.data!.docs.isNotEmpty){
          return ListView.builder(
            padding: const EdgeInsets.only(top: 15),
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context,int i){
             return InkWell(
              onTap: () {
                Get.toNamed('chatroom',arguments: {
                  'friendsid': snapshot.data!.docs[i]['friendsid'],
                  'id':controller.id,
                  'username':controller.username,
                  'friendid': controller.friendid(snapshot,i), 
                  'friendusername': controller.friendusername(snapshot, i),
                  'image': controller.friendimage(snapshot, i),
                });
              },
               child: HomemessageCard(
                username: controller.friendusername(snapshot, i),
                image: controller.friendimage(snapshot, i),
                lastmessage: controller.lastmessage(snapshot, i),
                messagetime: controller.formatMessageTime(snapshot,i),
               )
             );
          });
        }
        else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
        } else{
          return const Center(child: Text('No data available',style: TextStyle(color: AppColors.grey,fontSize: 18,fontWeight: FontWeight.w700)));
        }
        }
        );
    });
  }
}