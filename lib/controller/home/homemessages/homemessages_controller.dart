import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/core/functions/checkinternet.dart';
import 'package:mirshop/core/services/services.dart';

class HomemessagesController extends GetxController {

 late String id;
 late String username;
 MyServices myServices = Get.find();
 //UserinfoData userinfoData = UserinfoData(Get.find());
 CollectionReference<Map<String, dynamic>> firebaseFirestore = FirebaseFirestore.instance.collection('friendsinfo');
 String? otherusername;
 String? otherimage;
 String? otherid;
 bool? iscon ;

  forim()async {
    if(await checkInternet()){
      iscon = true;
    }else{
      iscon = false;
    }
  }

 Widget? formatMessageTime(AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>> snapshot,int i) {
  if(snapshot.data!.docs[i]['time'] == null){
   return null;
  }
  final DateTime dateTime = snapshot.data!.docs[i]['time'].toDate();
  final DateTime now = DateTime.now();
  final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    // Time is from today
    return Text(
      DateFormat.Hm().format(dateTime),
      style: const TextStyle(color: AppColors.grey, fontWeight: FontWeight.w700,fontSize: 17.5),
    );
  } else if (dateTime.year == yesterday.year &&
             dateTime.month == yesterday.month &&
             dateTime.day == yesterday.day) {
    // Time is from yesterday
    return const Text(
      'Yesterday',
      style: TextStyle(color: AppColors.grey, fontWeight: FontWeight.w700,fontSize: 15),
    );
  } else {
    // Time is from another day
    return Text(
      DateFormat('MM/dd/yyyy').format(dateTime),
      style: const TextStyle(color: AppColors.grey, fontWeight: FontWeight.w700,fontSize: 15),
    );
  }
}

  friendusername(AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>> snapshot,int i ){
    if(id == snapshot.data!.docs[i]['useroneid']){
      otherusername = snapshot.data!.docs[i]['usertwousername'];
    }else{
      otherusername = snapshot.data!.docs[i]['useroneusername'];
    }
    return otherusername;
  }

  /*getdata(String friendid) async {
    var response = await userinfoData.postdata(friendid);
    if(response == StatusRequest.offlinefailure){
     otherimage = null;
    }else{
     otherimage = response['data']['image'];
    }
    return otherimage;
  }*/
  
  friendimage(AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>> snapshot,int i )  {
    if(id == snapshot.data!.docs[i]['useroneid']){
      otherimage = snapshot.data!.docs[i]['usertwoimage'];
    }else{
      otherimage = snapshot.data!.docs[i]['useroneimage'];
    }
    return otherimage;
  }

  lastmessage(AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>> snapshot,int i ){
    String lastMessage = snapshot.data!.docs[i]['text'];
    if (id == snapshot.data!.docs[i]['sender']){
       return Text(lastMessage,style: const TextStyle(fontSize: 18,color: Colors.grey,fontWeight: FontWeight.w500),maxLines: 1);
    }else{
      if(snapshot.data!.docs[i]['view'] == false){
        return Text(lastMessage,style: const TextStyle(color: AppColors.black,fontWeight: FontWeight.w700,fontSize: 18),maxLines: 1);
      }else{
        return Text(lastMessage,style: const TextStyle(color: AppColors.grey,fontWeight: FontWeight.w600,fontSize: 18),maxLines: 1);
      }
    }
  }

  friendid(AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>> snapshot,int i){
    if(id == snapshot.data!.docs[i]['useroneid']){
      otherid = snapshot.data!.docs[i]['usertwoid'];
    }else{
      otherid = snapshot.data!.docs[i]['useroneid'];
    }
    return otherid;
  }

  Stream<QuerySnapshot<Map<dynamic, dynamic>>> source(){
    Stream<QuerySnapshot<Map<dynamic, dynamic>>> data = firebaseFirestore
    .where('roomemail', arrayContains: id)
    .orderBy('time', descending: true)
    .snapshots();
    return data;
  }

 @override
  void onInit() {
    id = myServices.sharedPreferences.getString('id').toString();
    username = myServices.sharedPreferences.getString('username')!;
    forim();
    super.onInit();
  }
}