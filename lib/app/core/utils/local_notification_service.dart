import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationPlugin =
  FlutterLocalNotificationsPlugin();

  static void intialize(BuildContext context) {
    final InitializationSettings initializationSettings =
    InitializationSettings(
      iOS: DarwinInitializationSettings(),
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),

    );
    _notificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse route) async {
          if (route != null) {
            print(route);
          }
    });
  }


  static Future<void> displayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        iOS: DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          "imy",
          "imy",
          // "gulshanclub",
        ),
        // android: AndroidNotificationDetails(
        // "gulshanclub",
        // "gulshanclub",
        // importance: Importance.max, priority: Priority.high
        // )
      );
      await _notificationPlugin.show(
        id,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: message.data["data"],
      );
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
