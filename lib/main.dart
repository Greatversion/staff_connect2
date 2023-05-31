import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff_connect/login_servics/login_check.dart';

import 'package:staff_connect/login_servics/login_screen.dart';
import 'package:staff_connect/mainUI/dashBoard.dart';

import 'package:staff_connect/onBoardingScreen/introScreen.dart';

import 'onBoardingScreen/onBoardingdata.dart';
import 'utilities/ReUsable_Functions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserDataProvider()),
        ChangeNotifierProvider(create: (context) => SelectedItemProvider()),
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
    title: "Search",
    desc: "dfbhhtbrtsntrtrhtrhtjntrj",
  ),
  OnbordingData(
    color: Colors.redAccent,
    imagePath: "assets/3.png",
    title: "Order",
    desc: "fegrgrgrgrgrgg",
  ),
  OnbordingData(
    color: Colors.brown,
    imagePath: "assets/2.png",
    title: "Eat",
    desc: "fegrgrgrgrgrgg.",
  ),
  OnbordingData(
    color: Colors.green,
    imagePath: "assets/5.png",
    title: "Eat",
    desc: "fegrgrgrgrgrggbasete.",
  )
];
