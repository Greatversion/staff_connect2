import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:staff_connect/utilities/notification_Services.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Notification_Services notificationServices = Notification_Services();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.userRequestAccessPermission();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
