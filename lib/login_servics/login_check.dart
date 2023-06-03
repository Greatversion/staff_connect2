import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginCheck extends StatefulWidget {
  const LoginCheck({super.key});

  @override
  State<LoginCheck> createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> checkCurrentUser(BuildContext context) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, "dashBoard");
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, "onBoarding");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentUser(context);
  }

  

  @override
  Widget build(BuildContext context) {
    var responsive = MediaQuery.of(context);
    return Scaffold(
      body: Container(
          height: responsive.size.height,
          width: responsive.size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 8, 78, 135),
            Color.fromARGB(255, 11, 9, 37)
          ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(seconds: 3),
                  child: Image.asset("assets/5.png")),
              const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.only(top: 60),
                height: 50,
                child: Image.asset("assets/2.png"),
              ),
              const SizedBox(height: 35),
              const SpinKitCircle(color: Colors.white, size: 50),
            ],
          )),
    );
  }
}
