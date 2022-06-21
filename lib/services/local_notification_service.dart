import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        // ignore: prefer_const_constructors
        InitializationSettings(
            // ignore: prefer_const_constructors
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: ((String? route) async {
      if (route != null) {
        Navigator.of(context).pushNamed(route);
      }
    }));
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "loyaltyprogram", "loyaltyprogram channel",
              importance: Importance.max, priority: Priority.high));

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.title,
        notificationDetails,
        payload: message.data["route"],
      );
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
