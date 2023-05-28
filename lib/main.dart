import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:staff_connect/login_servics/login_check.dart';
import 'package:staff_connect/login_servics/login_screen.dart';
import 'package:staff_connect/mainUI/dashBoard.dart';
import 'package:staff_connect/mainUI/settings.dart';
import 'package:staff_connect/onBoardingScreen/introScreen.dart';

import 'onBoardingScreen/onBoardingdata.dart';

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "dashBoard": (context) => const DashBoard(),
          "onBoarding": (context) => IntroScreen(list,const SignInScreen()),
        },
        home: const SettingsPage());
  }
}

final List<OnbordingData> list = [
    OnbordingData(
      color: Colors.indigo,
      imagePath: "assets/4.png",
      title: "Search",
      desc:
          "Discover restaurants by type of meal, See menus and photos for nearby restaurants and bookmark your favorite places on the go",
    ),
    OnbordingData(
      color: Colors.redAccent,
      imagePath: "assets/3.png",
      title: "Order",
      desc:
          "Best restaurants delivering to your doorstep, Browse menus and build your order in seconds",
    ),
    OnbordingData(
      color: Colors.brown,
      imagePath: "assets/2.png",
      title: "Eat",
      desc:
          "Explore curated lists of top restaurants, cafes, pubs, and bars in Mumbai, based on trends.",
    ),
    OnbordingData(
      color: Colors.green,
      imagePath: "assets/5.png",
      title: "Eat",
      desc:
          "Explore curated lists of top restaurants, cafes, pubs, and bars in Mumbai, based on trends.",
    )
  ];