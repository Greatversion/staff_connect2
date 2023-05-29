import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Notification_Services {
  FirebaseMessaging messages = FirebaseMessaging.instance;

  void userRequestAccessPermission() async {
    NotificationSettings settings =await messages.requestPermission(
      alert: true,
      announcement: true,
      provisional: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("USer Granted ");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("USer Granted Provisional permission ");
    } else {
      AppSettings.openNotificationSettings();
      print("User denied the permission");
    }
  }
}
