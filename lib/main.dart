import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:staff_connect/login_servics/login_check.dart';

import 'package:staff_connect/login_servics/login_screen.dart';
import 'package:staff_connect/mainUI/dashBoard.dart';


import 'package:staff_connect/onBoardingScreen/introScreen.dart';
import 'package:staff_connect/utilities/notification_Services.dart';
import 'onBoardingScreen/onBoardingdata.dart';
import 'utilities/ReUsable_Functions.dart';

String? token;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  token = await FirebaseMessaging.instance.getToken();
  // sendFcmToken();
  Notification_Services();
  print(token);
  runApp(const MyApp());
}

sendFcmToken() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  String? currentRegUser = _auth.currentUser!.email;
  final CollectionReference userCollection = store.collection('users');
  await userCollection
      .doc(currentRegUser)
      .set({'FCM Token': token}, SetOptions(merge: true));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserDataProvider()),
        ChangeNotifierProvider(create: (context) => LeaveProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            "dashBoard": (context) => const DashBoard(),
            "onBoarding": (context) => IntroScreen(list, const SignInScreen()),
          },
          home: const LoginCheck()),
    );
  }
}

final List<OnbordingData> list = [
  OnbordingData(
    color: Colors.indigo,
    imagePath: "assets/4.png",
    title: "Manage Tasks",
    desc: "Assign the work directly to the employees",
  ),
  OnbordingData(
    color: Colors.redAccent,
    imagePath: "assets/3.png",
    title: "Get in touch",
    desc: "Collaborate with your Collegues with Square",
  ),
  OnbordingData(
    color: Colors.brown,
    imagePath: "assets/2.png",
    title: "Salary Management",
    desc: "Manage your Leaves and Salaries",
  ),
  OnbordingData(
    color: Colors.green,
    imagePath: "assets/5.png",
    title: "Buisness Growth",
    desc: "Give Boost to your Buisness with Staff Connect",
  )
];
