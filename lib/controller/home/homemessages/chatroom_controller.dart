import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/functions/checkinternet.dart';

class ChatroomController extends GetxController {

  late String friendsid;
  late String id;
  late String friendid;
  late String username;
  late String friendusername;
  String? image;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late TextEditingController textEditingController;
  RxBool isEmpty = true.obs;
  StatusRequest statusRequest = StatusRequest.none;
  // for stream 
  bool isLoading = false;
  int documentLimit = 15;
  DocumentSnapshot? lastDocument;
  String? firstdoc;
  ScrollController scrollController = ScrollController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> messages = [];
  List? tokens;
  String? text;
  List<bool> whentap = [];
  bool? isactive ;

  updateview(String? receiver,String? path,String view)async{
    if(isactive == true){
      if(receiver == id){
        if(view == 'false'){
         await firebaseFirestore.collection('chatroom').doc(friendsid).collection('messages').doc(path).update({'view':true});
         await firebaseFirestore.collection('friendsinfo').doc(friendsid).update({'view':true});
        }
      }
    }
  }

  friendtoken() async {
    if(await checkInternet()){
    DocumentSnapshot<Map<dynamic, dynamic>>? res = await firebaseFirestore.collection('tokens').doc(friendid).get();
    Map<dynamic, dynamic>? ann = res.data();
    if(ann != null){
     tokens = ann['token'];
    }else {
      tokens = null;
    }
    }else{
      null;
    }
  }

  Future<void> sendPushNotification(String msg,String pushToken) async {
    final body = {
      "to": pushToken,
      "notification": {
        "title": username, 
        "body": msg,
      },
    };
    await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'key=AAAAbZiyqk0:APA91bG_yYfTscmD44hOMzvMUDco2I5oMD8PdjvmR8BDStSr6nTXLop0HLyf787Zdl1OF5Uwz3QMVf6kSmedSMf1HUMX747Bc3xn-BWfFdA1RkKOWV9YhPGTq4ODYUT6-0a_49yPyz4W'
      },
      body: jsonEncode(body));
  }

  getChats(){
   statusRequest = StatusRequest.loading;
   update();
   Stream<QuerySnapshot<Map<String, dynamic>>> firstmessages = firebaseFirestore
    .collection('chatroom')
    .doc(friendsid)
    .collection('messages')
    .orderBy('time', descending: true)
    .limit(documentLimit)
    .snapshots();
    firstmessages.listen(
      onError: (event){
      statusRequest = StatusRequest.serverfailure;
      update();
      },
      (snapshot){
      if(snapshot.docs.isNotEmpty == true){
        lastDocument = snapshot.docs.last;
        messages = snapshot.docs;
        firstdoc = snapshot.docs.first.id;
        for (var message in messages) {
           updateview(message['receiver'],message.id,message['view'].toString());
         }
        whentap = List<bool>.generate(messages.length, (index) => false); 
        statusRequest = StatusRequest.success;
      }else{
       statusRequest = StatusRequest.failure;
      }
      update();
    }
    );
  }
  
  morechats(){
    if (isLoading) {
    return; 
  }
  isLoading = true; 
  update();
  Stream<QuerySnapshot<Map<String, dynamic>>> moremessages = firebaseFirestore
    .collection('chatroom')
    .doc(friendsid)
    .collection('messages')
    .orderBy('time', descending: true)
    .limit(documentLimit)
    .startAfterDocument(lastDocument!)
    .snapshots();
    moremessages.listen((snapshot){
      if(snapshot.docs.isNotEmpty == true){
        lastDocument = snapshot.docs.last;
        messages.addAll(snapshot.docs);
        whentap = List<bool>.generate(messages.length, (index) => false);
        isLoading = false;
      }else{
        isLoading = false;
      }
      update();
    });
  }

  ss(){
    scrollController.addListener(() async {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        if(await checkInternet()){
          morechats();
        }else{
          internetSnackbar();
        }
      }
    });
  }

  removemessage(String? path)async{
    await firebaseFirestore
    .collection('chatroom')
    .doc(friendsid)
    .collection('messages')
    .doc(path)
    .delete();
  }

  Future<void> deletemessage(String? path, int i) async {
     if(await checkInternet()){
     if(firstdoc == path){
      removemessage(path);
      await firebaseFirestore
      .collection('chatroom')
      .doc(friendsid)
      .collection('messages')
      .orderBy('time', descending: true)
      .limit(1).get().then((value) => firebaseFirestore.collection('friendsinfo').doc(friendsid).update(value.docs.first.data()));
      }
      else{
      removemessage(path);
     }
    }else{
      internetSnackbar();
    }
    update();
  }

  String messageTime(int i) {
  Timestamp timestamp = messages[i]['time'];
  DateTime dateTime = timestamp.toDate();
  String messagetime = DateFormat.Hm().format(dateTime);
  return messagetime;
  }

  void change(String value) {
    isEmpty.value = value.isEmpty;
  }

  Future<void> sendmessage()async{
    if(await checkInternet()){
    isEmpty.value = true;
    text = textEditingController.text;
    textEditingController.clear();
    DateTime currentTime = DateTime.now();
    Timestamp timestamp = Timestamp.fromDate(currentTime);
      sendnewmessage(timestamp).then((value) {
      if(tokens != null){
       for (String? tkn in tokens!) {
        sendPushNotification(text!,tkn!);
       }
      }else{
        null;
      }
    });
    updatelastmessage(timestamp);
    }else{
      internetSnackbar();
    }
  }
  
  updatelastmessage(Timestamp timestamp)async{
    await firebaseFirestore.collection('friendsinfo').doc(friendsid).update({
      'sender': id,
      'text' : text,
      'time' : timestamp,
      'view' : false
    });
  }
 
  sendnewmessage(Timestamp timestamp)async{
    await firebaseFirestore.collection('chatroom').doc(friendsid).collection('messages').add({
      'receiver': friendid,
      'sender': id,
      'text': text,
      //'time' : FieldValue.serverTimestamp(),
      'time' : timestamp,
      'view' : false
    });
  }

 String formatMessageTime(int i) {
  final DateTime dateTime = messages[i]['time'].toDate();
  final DateTime now = DateTime.now();
  final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    // Time is from today
    return 'Today';
  } else if (dateTime.year == yesterday.year &&
             dateTime.month == yesterday.month &&
             dateTime.day == yesterday.day) {
    // Time is from yesterday
    return 'Yesterday';
  } else {
    // Time is from another day
    return DateFormat('MMMM d, yyyy').format(dateTime);
  }
}

 String messageview(int i){
  bool isview = messages[i]['view'];
  if(isview == true){
   return ' seen';
  }else{
   return ' sent';
  }
 }

 void showview(int i) {
  whentap[i] = !whentap[i];
  update();
}
  
  @override
  void onInit() {
    friendsid = Get.arguments['friendsid'];
    id = Get.arguments['id'];
    friendid = Get.arguments['friendid'];
    username = Get.arguments['username'];
    friendusername = Get.arguments['friendusername'];
    image = Get.arguments['image'];
    isactive = true;
    textEditingController = TextEditingController();
    getChats();
    ss();
    friendtoken();
    super.onInit();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}