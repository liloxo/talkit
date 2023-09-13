import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:mirshop/core/functions/fcmconfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  
  late SharedPreferences sharedPreferences ; 

  Future<MyServices> init() async {
  sharedPreferences = await SharedPreferences.getInstance() ; 
  await Firebase.initializeApp();
  NotificationService().initNotification();
  requestper();
  fcml();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  return this ; 
  }
}

initialServices() async  {
  await Get.putAsync(() => MyServices().init()) ; 
}