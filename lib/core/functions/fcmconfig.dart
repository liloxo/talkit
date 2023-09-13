import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

  requestper()async{
   FirebaseMessaging messaging = FirebaseMessaging.instance;
   await messaging.requestPermission(
   alert: true,
   announcement: false,
   badge: true,
   carPlay: false,
   criticalAlert: false,
   provisional: false,
   sound: true,
   );
  }

  fcml(){
   FirebaseMessaging.onMessage.listen((event) async {
    return NotificationService().showNotification(title: event.notification!.title!,body: event.notification!.body!);
   });
  }

  Future backgroundHandler(RemoteMessage event) async {
  }

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
     FlutterLocalNotificationsPlugin();
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('talkitlogo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
            await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId', 
          'channelName',
          priority : Priority.high,
          importance: Importance.max,
          channelShowBadge: true,
          largeIcon: DrawableResourceAndroidBitmap('talkitlogo')),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}